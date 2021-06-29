
# Demo Web App using flask

This simple image deploy a "web app" that show random cats GIF from a list of images declared in the app.py file.

The flask app also provided a healthcheck status page using the py-healthcheck python library.

## Tested with: 

| Environment | Application | Version  |
| ----------------- |-----------|---------|
| WSL2 Ubuntu 20.04 | Docker | 20.10.7  |
| WSL2 Ubuntu 20.04 | aws-cli | v2.2.12 |
| WSL2 Ubuntu 20.04 | Python | 3.8.5 |



## Run App.py Locally

Clone the project

```bash
  git clone https://github.com/JManzur/flask-demo.git
```

Go to the project directory

```bash
  cd flask-demo
```

If you wish to test the python app locally, install the requirements:

```bash
  pip3 install -r requirements.txt
```

Start the server

```bash
  python3 app.py
```

Access the web app:

http://127.0.0.1:5000/

And you will see something like this:

![App Screenshot](https://1.bp.blogspot.com/-FZfHhOgKacc/YMuy5wxc_7I/AAAAAAAAFkg/IsxfxuE7sNAC1PRhgt1OFeuCZBh5IBU8gCLcBGAsYHQ/w400-h395/flask-demo.png)

## Test the healthcheck status page

In order to test the healthcheck status page, you can access http://127.0.0.1:5000/status in a browser or perform a curl like this:

```bash
  curl http://127.0.0.1:5000/status
```

:bulb: **TIP**: Use "python -m json.tool" to prettify the json output

```bash
  curl -s http://127.0.0.1:5000/status | python3 -m json.tool
```

![App Screenshot](https://1.bp.blogspot.com/-GM2nkXXTSkY/YMu4IJoFQmI/AAAAAAAAFko/iS6AtNOx-YYmrNIFbzHasOCPZ3iNuxYwACLcBGAsYHQ/s16000/flask-demo-healthcheck.png)

## Build the Docker image 

Form the project directory run:

```bash
docker build -t flask-demo .
```

## Run the Docker image Locally

After building the image if you wish to test it locally run the following command.

Copy the IMAGE_ID
```bash
docker image ls
```

Run the image
```bash
docker run -d -p 5000:5000 --name DEMO {IMAGE_ID}
```

## Push to ECR

Tag the image. You can use a GUID generator for the tag.

```bash
docker tags flask-demo-mps:latest YOUR_ECR_URL.ecr.us-east-1.amazonaws.com/prod/REGISTRY_NAME:GUID
```

Link the AWS Account:
```bash
aws configure
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin YOUR_ECR_URL.ecr.us-east-1.amazonaws.com/prod/REGISTRY_NAME
```

Push de la imagen:
```bash
docker push YOUR_ECR_URL.ecr.us-east-1.amazonaws.com/prod/REGISTRY_NAME:GUID
```

## Troubleshooting

#### Known issue #1: Error during docker built
 - **Issue**: During the docker build you receive the following error:

    ```bash
    ERROR: failed to authorize: rpc error: code = Unknown desc = failed to fetch oauth token: │ unexpected status: 400 Bad Request
    ```

- **Cause**: Temporary communication problem with docker hub.

- **Solution**: Re-run the docker build command (or terrafrom manifest).

## Author

- [@jmanzur](https://github.com/JManzur)

  
## Documentation

- [Python - Docker Official Images](https://hub.docker.com/_/python)
- [Online GUID / UUID Generator](https://www.guidgenerator.com/)
- [py-healthcheck library](https://pypi.org/project/py-healthcheck/)
