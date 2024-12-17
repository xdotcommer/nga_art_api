Here’s an updated and improved `README.md` tailored for your **Sinatra + Grape API** project:

---

# National Gallery Open Access API

This project is a lightweight API for accessing National Gallery Open Access content. Built with **Sinatra** and **Grape**, the API is designed to be modular, scalable, and developer-friendly. It provides endpoints for fetching and searching open access content.

---

## Features

- **Sinatra**: Serves as the foundation for the application.
- **Grape**: Handles structured, modular API endpoints.
- **Swagger Integration**: Auto-generated API documentation.
- **Authentication**: API key-based authentication.
- **Dockerized**: Easy deployment with Docker.
- **Scalable**: Ready for deployment to platforms like AWS ECS, Fly.io, or Render.

---

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Setup](#setup)
  - [Local Setup](#local-setup)
  - [Docker Setup](#docker-setup)
- [Usage](#usage)
  - [Available Endpoints](#available-endpoints)
  - [Testing with `curl`](#testing-with-curl)
- [Deployment](#deployment)
  - [AWS ECS (Fargate)](#aws-ecs-fargate)
- [Contributing](#contributing)
- [License](#license)

---

## Requirements

- **Ruby**: Version `3.2.5` or higher
- **Bundler**: Version `2.0` or higher
- **Docker**: For containerized deployment

---

## Setup

### Local Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/xdorcommer/National Gallery-openaccess-api.git
   cd National Gallery-openaccess-api
   ```

2. **Install Dependencies**
   Ensure you have Ruby and Bundler installed, then run:

   ```bash
   bundle install
   ```

3. **Start the Server**
   Start the application locally using `rackup`:

   ```bash
   bundle exec rackup -o 0.0.0.0 -p 9292
   ```

4. **Access the Application**
   - Base URL: `http://localhost:9292`
   - Swagger Documentation: `http://localhost:9292/openaccess/docs`

---

### Docker Setup

1. **Build the Docker Image**

   ```bash
   docker build -t National Gallery-openaccess-api .
   ```

2. **Run the Docker Container**

   ```bash
   docker run -p 9292:9292 National Gallery-openaccess-api
   ```

3. **Access the Application**
   Test the endpoints using `curl` or a browser as described in the [Usage](#usage) section.

---

## Usage

### Available Endpoints

| Method | Path                               | Description                          |
| ------ | ---------------------------------- | ------------------------------------ |
| `GET`  | `/openaccess/ping`                 | Health check. Returns `status: ok`.  |
| `GET`  | `/openaccess/content/:id`          | Fetch content by ID.                 |
| `GET`  | `/openaccess/stats`                | Fetch stats for CC0 objects/media.   |
| `GET`  | `/openaccess/search`               | Search content.                      |
| `GET`  | `/openaccess/category/:cat/search` | Search within a specific category.   |
| `GET`  | `/openaccess/terms/:category`      | Fetch terms for a specific category. |
| `GET`  | `/openaccess/docs`                 | Swagger documentation.               |

---

### Testing with `curl`

#### **1. Health Check**

```bash
curl -X GET "http://localhost:9292/openaccess/ping"
```

**Response**:

```json
{ "status": "ok" }
```

#### **2. Fetch Content**

```bash
curl -X GET "http://localhost:9292/openaccess/content/edanmdm-nmaahc_2012.36.4ab" \
     -H "X-Api-Key: 12345"
```

#### **3. Search**

```bash
curl -X GET "http://localhost:9292/openaccess/search" \
     -H "X-Api-Key: 12345" \
     -G --data-urlencode "q=example" \
     --data-urlencode "sort=newest" \
     --data-urlencode "rows=10"
```

#### **4. Fetch Stats**

```bash
curl -X GET "http://localhost:9292/openaccess/stats" \
     -H "X-Api-Key: 12345"
```

#### **5. Search by Category**

```bash
curl -X GET "http://localhost:9292/openaccess/category/art_design/search" \
     -H "X-Api-Key: 12345" \
     -G --data-urlencode "q=example"
```

---

## Deployment

### AWS ECS (Fargate)

1. **Push the Docker Image to ECR**

   ```bash
   aws ecr create-repository --repository-name National Gallery-openaccess-api
   docker tag National Gallery-openaccess-api:latest <account-id>.dkr.ecr.<region>.amazonaws.com/National Gallery-openaccess-api:latest
   docker push <account-id>.dkr.ecr.<region>.amazonaws.com/National Gallery-openaccess-api:latest
   ```

2. **Create an ECS Cluster and Task Definition**
   Use the [AWS CLI](https://aws.amazon.com/cli/) or the AWS Management Console to configure your cluster and task.

3. **Integrate with API Gateway**
   Set up an API Gateway to route public traffic to your ECS service.

Refer to the [AWS ECS Deployment Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html) for detailed steps.

---

## Contributing

Contributions are welcome! Please fork this repository, create a feature branch, and submit a pull request.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

```

```
