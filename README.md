njsdoc Dockerfile
================

A handy dockerfile for running njsdoc to document some code. Use it as-is or extend it via FROM and do something else.


What is `njsdoc`?
-------------

[njsdoc](https://bitbucket.org/nexj/njsdoc) is a JavaScript code document generator. All document generators read the code and do some analysis. Most read
the code directly as it is stored at rest in the file system, a job commonly referred to as static analysis. njsdoc
executes the code in a modified Rhino environment and analyzes it at runtime. This allows a lot of JavaScript's
run-time beauty to shine through, without needing to code a certain way or annotation with arcane syntax in weird ways.


What is `Docker`?
-------------

[Docker](https://www.docker.com/) is an open platform for developers and sysadmins to build, ship, and run distributed applications.
It is used here to wrap njsdoc itself and it's dependencies - namely Java - into a single container that can be used as
an application with the only dynamic dependency being the code to document.

How can I use this?
-------------

This image assumes that you have some JavaScript source code to document.

This image is designed so that this code to document is mounted as a volume into a container and then read.

1. [Install Docker](https://docs.docker.com/installation/#installation)
2. Download this image
  - `docker pull r4j4h/njsdoc`
  - Or to manually build this image:
      - Download [https://github.com/r4j4h/njsdoc-dockerfile](https://github.com/r4j4h/njsdoc-dockerfile)
      - `docker build -t="r4j4h/njsdoc:0.0.7" .`
3. Run a container from this image with your code:
  - Assuming a folder /path-to-your-code/ exists with a my-source.js file...
  - `docker run --rm -v /path-to-your-code:/code_in r4j4h/njsdoc:0.0.7 /code_in/my-source.js --markdown`
      - This tells docker to clean up this container when we are done so we do not pile up used containers.
      - We link a local volume, which should be pointed to your code
      - Notice we can pass in any normal arguments as per njsdoc's documentation
  - njsdoc by default returns the output via stdout.
  - njsdoc provides output control options - in this case we still want docker to clean up the container, but we want
  to keep the output.
        - `docker run --rm -e CODE_PATH=/code_in -e DOC_PATH=/docs -v ./path-to-your-code:/code_in -v /desired-path-to-your-docs:/docs <image> r4j4h/njsdoc:0.0.7 /code_in/my-source.js --markdown --out /docs/my-source.md`
        - This is the same command as before, modified slightly:
          - We link another local volume, which should be pointed to where you want your generated code to go.
          - We have added `--out /docs` to inform jsdoc to not push out to stdout but to write to our destined file system
          meeting point.
