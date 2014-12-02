njsdoc Dockerfile

A handy dockerfile for running njsdoc to document some code. Use it as-is or extend it via FROM and do something else.


What is njsdoc?

`njsdoc` is a JavaScript code document generator. All document generators read the code and do some analysis. Most read
the code directly as it is stored at rest in the file system, a job commonly referred to as static analysis. njsdoc
executes the code in a modified Rhino environment and analyzes it at runtime. This allows a lot of JavaScript's
run-time beauty to shine through, without needing to code a certain way or annotation with arcane syntax in weird ways.


What is Docker?

`Docker` is a convention around using "container" technologies, such as `lxc`. It provides a common standard referred to
as a `Dockerfile` used to declare a set of commands to be executed on a versioned file system. It is used here to wrap
 njsdoc itself and it's dependencies - namely Java - into a single container that can be used as an application, more
  like what we expect `njsdoc` to be. (And it is, just with the help of Java).

How can I use this?

1. Install Docker
  - TODO Insert link to docker installation instructions page
2. Download this image
  - TODO Add link to simple way
3. Build this image
  - `docker build -t="njsdoc:0.0.7" `
3. Run a container from this image with your code:
  - `docker run --rm -e CODE_PATH=/code_in  -v ./path-to-your-code:/code_in <image> njsdoc:0.0.7 my-source.js --markdown`
    - This tells docker to clean up this container when we are done so we do not pile up used containers.
    - We pass an environmental variable because I wanted to keep this flexible. You do need to specify it.
    - We link a local volume, which should be pointed to your code, into the path we put in the environment variable.
    - Notice we can pass in any normal arguments as per njsdoc's documentation, just without specifying java or its jar.
  - njsdoc by default returns the output via stdout.
  - njsdoc provides output control options - in this case we still want docker to clean up the container, but we want
  to keep the output.
  - `docker run --rm -e CODE_PATH=/code_in -e DOC_PATH=/docs -v ./path-to-your-code:/code_in -v /desired-path-to-your-docs:/docs <image> njsdoc:0.0.7 my-source.js --markdown --out /docs`
    - This is the same command as before, modified slightly.
      - We have defined yet another environment variable, `DOC_PATH`. This is to allow us to configure where our generated
      documents should be stored.
      - We link another local volume, which should be pointed to where you want your generated code to go.
      - We have added `--out /docs` to inform jsdoc to not push out to stdout but to write to our destined file system
      meeting point.

docker run --rm -ti -v /vagrant/flsjs/dccharts-package/:/code_in njsdoc:0.0.7 /code_in/core.js /code_in/charts/BasicPieChart.js /code_in/charts/MinimalWiringChart.js

