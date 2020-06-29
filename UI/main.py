from flask import Flask, render_template, request
import requests
app = Flask(__name__)

solr_url = 'http://localhost:8983/solr/lyrics'

def ceildiv(a, b):
    return -(-a // b)

@app.route("/")
def hello():
    query = request.args.get('q')

    if query:
        page = request.args.get('page', 1)
        page = int(page)
        results_per_page = 1000
        start = (page - 1) * results_per_page
        res = requests.get(solr_url+'/query', params={
            'q': query,
            #'qf': 'title',
            'start': start,
            'rows': results_per_page,
            'wt': 'json',
        })

        if not res.ok:
            try:
                print(res.json()['error']['msg'])
            except:
                print(res.text)

        solr_response = res.json()['response']
        page_max = ceildiv(solr_response['numFound'], results_per_page)

        return render_template('search.html',
                               query=query,
                               solr=solr_response,
                               page=page,
                               page_max=page_max)
    else:
        return render_template('search.html')

if __name__ == "__main__":
    from tornado.wsgi import WSGIContainer
    from tornado.httpserver import HTTPServer
    from tornado.ioloop import IOLoop

    http_server = HTTPServer(WSGIContainer(app))
    port = 5000
    http_server.listen(port, address='localhost')
    print('Listening on port %d.' % port)
    IOLoop.instance().start()
