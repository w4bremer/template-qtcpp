import CodeBlock from '@theme/CodeBlock';
import helloWorldModuleComponent from '!!raw-loader!./data/helloworld.module.yaml';
import Figure from '../figure'

# Features

This guide explains how to use the generated code, what are the available features and  their benefits.

## Get started

This template generates code for [*Qt*](https://www.qt.io/) projects. In order to successfully compile and use the code, you need to have the *Qt Engine* installed (at least 5.12). Check [the Qt website](https://www.qt.io/download) for your options for open-source or commercial version.
Basic understanding of *Qt* is required, and depending on your goal the qml or c++ knowledge is also necessary.

### Code generation
Follow the documentation for the [code generation](https://docs.apigear.io/docs/start/first_steps) in general and [CLI](https://docs.apigear.io/docs/cli/generate) or the [Studio](https://docs.apigear.io/docs/category/desktop-studio) tools.
Or try first the [quick start guide](../quickstart/index.md) which shows how to prepare api and generate code out of it.

:::tip
For questions regarding this template please go to our [discussions page](https://github.com/orgs/apigear-io/discussions). For feature requests or bug reports please use the [issue tracker](https://github.com/apigear-io/template-qtcpp/issues).
:::

### Example API

The following code snippet contains the *API* which is used throughout this guide to demonstrate the generated code and its usege in *Qt*.

<details><summary>Hello World API (click to expand)</summary>
<CodeBlock language="yaml" showLineNumbers>{helloWorldModuleComponent}</CodeBlock>
</details>

## Features

### Core
Features generate a view model for the `api`. This can be used to implement a working *C++* and *qml* service and directly use it in your UI project.
- [api](api.md) - generates compilable abstract base interface and a basic implementation for data types
- [stubs](stubs.md) - adds a basic stubs for the `api`, you'll get classes that can actually be instantiated
- [qmlplugin](qmlplugin.md) - generates plugin which can be used to add the qml types

### Extended
Features can be used in combination with `api` and add more functionality on top, like the simulation
- [olink](olink.md) - provides a client and server adapters for each interface, that can be connected to any of the other technology templates with support for [ObjectLink](https://docs.apigear.io/objectlink/). Use this feature to connect with ApiGear simulation tools.
- [monitor](monitor.md) - generates a middleware layer which logs all API events to the [CLI](https://docs.apigear.io/docs/category/command-line) or the [Studio](https://docs.apigear.io/docs/category/desktop-studio)
-  examples feature - generates:
    - `olinkserver` example with `main.cpp` that shows your services in olink server.
    - `olinkclient` example with `main.cpp` that shows your interfaces as olink client.
    - `qml` example with a `main.cpp` and `qmlmain.qml`. The qml uses your interfaces. The main cpp sets olink client factory as a backend for the qml and sets up the olink server with your services (normally you'd have separate app for server)'.

<Figure caption="Use a subset of shown features for UI application." src="/img/features/featuresApp.png" />
<Figure caption="Features that may be used for server application." src="/img/features/featuresServer.png" />

There is also an *internal* feature `apigear`, which is generated for the *extended* features and is explained with them.
Each feature can be selected using the solution file or via command line tool.
:::note
*Features are case sensitive, make sure to always **use lower-case.** *
:::
:::tip
The *meta* feature `all` enables all specified features of the template. If you want to see the full extent of the generated code `all` is easiest solution.
Please note, `all` is part of the code generator and not explicitly used within templates.
:::
## Folder structure

This graph shows the full folder structure which is generated for `all` features enabled. Generated features are encapsulated in separate folders inside the module folder, here `io_world` or for the common features like `examples` and the internal helper feature `apigear`, a level above, in the `generation layer` level, here `qt_hello_world`. For more details visit the documentation for each feature. 
A `thirdparty` folder is contains Qt Promise (up to 5.x.x Qt version).

```bash
📂hello-world
 ┣ 📂apigear
 ┃ ┣ 📜helloworld.solution.yaml
 ┃ ┗ 📜helloworld.module.yaml
 ┣ 📂qt_hello_world
 ┃ ┣ 📂apigear
 ┃ ┣ 📂examples
 ┃ ┃ ┣ 📂olinkclient
 ┃ ┃ ┣ 📂olinkserver
 ┃ ┃ ┣ 📂qml
 # highlight-next-line
 ┃ ┣ 📂io_world
 ┃ ┃ ┣ 📂api
 ┃ ┃ ┣ 📂implementation
 ┃ ┃ ┣ 📂monitor
 ┃ ┃ ┣ 📂olink
 ┃ ┃ ┗ 📂plugin
 ┃ ┣ 📂thirdparty
 ┃ ┗ 📜CMakeLists.txt
```
