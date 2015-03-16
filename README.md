## TypeScript - Boilerplate
This is a TypeScript boilerplate project to start TypeScript development in web projects. The project's aim is to 
provide a boilerplate to develop, compile and release TypeScript Web-Applications with a NodeJS ExpressJS base.

##### Build
Sourcecode is build by **Gulp.JS** and the following features are provided via gulp tasks.

  * Bower packaging
  * TypeScript compilation
  * LiveReload (development)
  * Express reload (development)
  * SASS support via Compass
  * TSD typing support via TSD manager see `tsd.json` for details

#### Prerequisites

  1. Install gulp `npm install -g gulp`
  2. Install compass `gem install compass`
  3. Install tsd `npm install -g tsd`
  3. Install bower `npm install -g bower`
  5. Install LiveReload browser extension.
  
##### Install packages
  
  1. Install bower packages by entering `bower install .`
  2. Install node modules `npm install .`
  
#### Getting started

Execute `gulp develop` to build the project with development settings. Every time a component in the the backend changes 
the Express instance will be restart. Please note in order to notify the browser of changes automatically the LiveReload 
Plugin needs to be installed and activated.

  * Enter `gulp help` to see available gulp tasks
  * To start developing open a Terminal and execute `gulp dev`
  * Wait for the gulp task to finish
  * Then open a browser browser and go to `http://127.0.0.1:3003`.
  * Go to `src/assets/script/main.ts` and make some changes
  * Save your changes to `main.ts`. This will trigger a build and reload your browser (if LiveReload is installed and enabled)

#### Todo's

  * More infos README.md
  * Clean up TypeScript definition files & package.json
  
####(The MIT License)

Copyright (c) 2015 Alexander Pirsig <self@pirsig.net>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.