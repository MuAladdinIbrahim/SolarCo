# SolarCo (Back End)

You could find the Front end part with Angular from [here](https://github.com/zeyadsaleh/SolarCo)

This API serves a web app about solar system installations (All info can be found in the link above).It provides various end points. Including: Clients, Contractors, Systems, Calculations, Posts, Offers and more.

### Prerequisites

You should have `ruby`, `rails`, `postgres` and `redis` installed. If you don't, install ruby and rails from [here](https://gorails.com/setup/ubuntu/20.04), postgres from [here](https://www.postgresql.org/download/) and redis from [here](https://redis.io/download).

### Installing
1. Download the zipped file and unzip it or Clone it
2. Run this command to install the packages needed
    ```sh
    $ bundle install
    ```
3. Run this command to create the database and migrate tables
    ```sh
    $ rake db:create db:migrate
    ```
4. Run this command to seed the database with data
    ```sh
    $ rake db:seed
    ```
5. Run this command to open the server
    ```sh
    $ rails s
    ```
### Technologies

- **Ruby on Rails** => API only App with no views

### License
MIT License

Copyright (c) 2020 [Nouran Samy](https://github.com/Nouran96) - [Zeyad Saleh](https://github.com/zeyadsaleh) - [Ahmed Abdelhamid](https://github.com/Ahmed-Abd-elhamid) - [Muhammed Alaa](https://github.com/MuAladdinIbrahim)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
