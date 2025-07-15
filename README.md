# Job Marketplace API

This is a Ruby on Rails API for a simple job marketplace, where job seekers can browse opportunities and apply. When an application is submitted, both the company and the applicant receive an email notification.

---

## Requirements

- Ruby (>= 3.2)
- Rails (8.x)
- PostgreSQL
- Redis
- Sidekiq
- curl

---

## Running with Dev Containers (VS Code)

This project is fully compatible with [**Development Containers**](https://code.visualstudio.com/docs/devcontainers/containers) in **Visual Studio Code**.

### What You Need

- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker](https://www.docker.com/) running locally

### How to Run

1. Open the project in VS Code.
2. When prompted, click **“Reopen in Container”**.
3. VS Code will build the development environment using `.devcontainer`.
4. Once setup is complete, the app and Sidekiq will start automatically.
5. You can begin testing the API right away.

---

## Manual Setup (Without Dev Container)

If you're **not using Dev Containers**, you can still run the app locally by executing:

```bash
bin/setup
```

This will:

Install Ruby gems

Setup the database (db:prepare)

Seed sample data

Start the Rails server using bin/dev

Make sure Redis is running locally before executing bin/setup.

## Email Notifications

When a job seeker applies for a job:

- An email is sent to the **client**
- Another email is sent to the **job seeker**


### View Emails with `letter_opener_web`

You can preview emails sent by the app using the `letter_opener_web` gem.

- Visit: [http://localhost:3000/letter_opener](http://localhost:3000/letter_opener) after submitting an application.


### Email Previews

You can also preview the email templates directly:

- **Client Email Preview**
  [http://localhost:3000/rails/mailers/client_mailer/new_application_received](http://localhost:3000/rails/mailers/client_mailer/new_application_received)

- **Job Seeker Email Preview**
  [http://localhost:3000/rails/mailers/job_seeker_mailer/application_received](http://localhost:3000/rails/mailers/job_seeker_mailer/application_received)


## Test the API with cURL

You can test the core functionality of the API — applying for a job — using `curl` commands.

### 1. List Available Opportunities

```bash
curl -X GET "http://localhost:3000/api/v1/opportunities" \
  -H "Accept: application/json"
```

This will return a paginated list of job opportunities.

## 2. List Opportunities with Search and Pagination (e.g., search by title)

```bash
curl -G "http://localhost:3000/api/v1/opportunities" \
  --data-urlencode "search=Engineer" \
  --data-urlencode "page=1" \
  -H "Accept: application/json"
```

This will return a paginated list of job opportunities.

### 3. Add an Opportunity

To create a new job opportunity, use the following cURL command:

```bash
curl --request POST \
  --url http://localhost:3000/api/v1/opportunities \
  --header 'Content-Type: application/json' \
  --data '{
    "title": "Senior Developer",
    "description": "An exciting role working with Ruby on Rails.",
    "salary": 90000,
    "client_id": 1
  }'
```


### 4. Apply to an Opportunity

Assuming you have a valid `opportunity_id` and `job_seeker_id` (you can check these using the `/opportunities` endpoint or from the seeded data):

```bash
curl --request POST \
  --url http://localhost:3000/api/v1/opportunities/{opportunity_id}/apply \
  --header 'Content-Type: application/json' \
  --data '{
    "job_seeker_id": {job_seeker_id}
  }'
```

#### Expected Result

- A new job application is created.
- A background job is enqueued to send notification emails.
- You can view the emails at: [http://localhost:3000/letter_opener](http://localhost:3000/letter_opener)

## Seed Data

During setup, sample data will be created automatically:

- 10 clients with job postings
- 10 job seekers
- 2 job opportunities per client


## Background Jobs

We use Sidekiq for background job processing. After applying to a job, two emails are enqueued.

You can view and manage Sidekiq jobs at:

http://localhost:3000/sidekiq
