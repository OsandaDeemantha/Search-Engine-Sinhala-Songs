# Search-Engine-Sinhala-Songs

**A sinhala/english text search engine for sinhala songs and lyrics**

# Getting Started

## Prerequisites

You must have the following prerequisites on your machine/server
 - [Docker](https://www.docker.com/)
 - [Docker Compose](https://docs.docker.com/compose/)

## How to Run

 - Clone or download the reposity
 - Open a terminal on the project root directory
 - Run `sh start.sh`
 - Wait for a few minutes to initialize the servers. (you can check status of containers by running `docker ps -a`)
 - Visit [http://localhost:5000](https://www.docker.com/) in your browser

## How to Search

After running the application you will have the access to a nice web interface that you can search and browse for your favourite sinhala songs, artists, lyrics, etc.

## Clean All

In order to stop servers and remove all container artifacts, run `sh stop.sh`


[========]


## Features

- Search by title - ආදරේ මන්දිරේ
- Search by artist - එඩ්වඩ් ජයකොඩි ගායනා කල ගී
- Search by lyrics - ඔබ සඳක් සේම පායා මට එලිය දුන් වගයි
- Search by genre - චිත්‍රපට ගීත
- Search by songwriter - රත්න ශ්‍රී ලියූ ගීත
- Faceted Search - Filter the search results based on artist, music, lyrics, genre
- Range Queries - ජනප්‍රියම ගීත 20, රත්න ශ්‍රී ලියූ හොඳම සිංදු 10, වික්ටර් රත්නායක ගායනා කළ හොඳම ගීත 10
- Search with synonyms - එඩ්වඩ් ජයකොඩි ගායනා කල ගී, එඩ්වඩ් ජයකොඩි ගැයූ සිංදු
- English support for searching (limited level) - Amaradewa top 10, Songs written by Rathna Sri

## Folder Structure

Folder  | Description
------------- | -------------
UI  | Flask server and web UI files
Data | Scraped sinhala songs and DB mount folder
Scraper | Python web scraper
Solr-Engine | Apache Solr

## Data

Song lyrics along with the metadata was scraped from [Sinhala Song Book](https://sinhalasongbook.com/) website. The website consists of following data fields for each song.

- Title (Sinhala & English)
- Artist (English)
- Genre (English)
- Lyrics (Sinhala)
- Songwriter (English)
- Music (English)
- Key
- Beat
- Views (Count)

*Artist, Genre, Songwriter, Music fields were translated to sinhala in order to support both sinhala and english for searching.*

## Indexing and Querying Process



