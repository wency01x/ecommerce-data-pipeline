# E-Commerce Data Ingestion Pipeline

This project is a simulation that demonstrates a complete data ingestion pipeline for an e-commerce platform. It is designed to process large datasets efficiently without overwhelming system memory by utilizing data chunking techniques.

The underlying infrastructure is deployed using Docker Compose, which automatically spins up an isolated PostgreSQL database and a pgAdmin web interface for seamless database administration. 

The core of the pipeline is a Python script running inside its own custom Docker container. This script reads the raw data, connects to the PostgreSQL database across a dedicated Docker network, and ingests the data in chunks of 100,000 rows at a time. The pipeline is designed to be portable and flexible, using argument parsing to dynamically accept database credentials and file paths directly from the command line.