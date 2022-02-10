# CONTRIBUTING

Make sure you have the following software installed:

1. Node.js
2. pnpm
3. watchman

Clone the repo:

    git clone ...

Install dependencies:

    pnpm install

Run the build:

    make build

Define the following environment variables:

    export PROJECT__ROOT="$PWD"
    export PATH="$PROJECT__ROOT/.bin:$PATH"

Now you have `asap` executable available which rebuilds the `bin/` source code
on each invocation:

    asap --help

To typecheck the project:

    make check

We use [debug][] npm package for debig logs, enable it by setting `DEBUG`
environment variable:

    DEBUG='asap:*' asap

## Code Organization

The `bin` directory hosts the `asap` executable code with `main.ts` being the
entry point (this is the module which is being run when you invoke `asap`):

    bin
    ├── Build.ts
    ├── main.ts
    ├── PromiseUtil.ts
    ├── RouteSet.ts
    ├── types.ts
    └── Watch.ts

The `src` directory hosts the `asap` library which is a client side application
framework:

    src
    ├── index.tsx
    ├── Router.ts
    └── Routing.ts