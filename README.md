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
 - Run `$ sh start.sh`
 - Wait for a few minutes to initialize the servers
 - Visit [http://localhost:5000](https://www.docker.com/) in your browser

## How to Search

After running the application you will have the access to a nice web interface that you can search and browse for your favourite sinhala songs, artists, lyrics, etc.

## Clean All

In order to stop servers and remove all container artifacts, run `$ sh stop.sh`.

# Approach

## Features

- Search songs by their title, artist, genre, lyrics etc.
- Faceted Search
- Range Queries
- Search with synonyms
- Both Sinhala & English support for searching

## Folder Structure

Folder  | Description
------------- | -------------
UI  | Flask server and web UI files
Data | Scraped sinhala songs and DB mount folder
Scraper | Python web scraper
Solr-Engine | Apache Solr

## Structure of Songs Data

Structure of songs data

## Scraping

how to scrap sinhala songs

