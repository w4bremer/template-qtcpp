{{- $features := .Features }}
{{- range .System.Modules }}
{{- $module := . }}
{{- range $module.Interfaces }}
{{- $interface := . }}
#include "{{snake $module.Name}}/implementation/{{ lower ( camel $interface.Name) }}.h"
#include "{{snake $module.Name}}//olink/olink{{ lower ( camel $interface.Name) }}adapter.h"
{{- if $features.monitor }}
#include "{{snake $module.Name}}/monitor/{{ lower ( camel $interface.Name) }}traced.h"
{{- end }}
{{- end }}
{{- end }}

#include <QtCore>
#include "apigear/olink/olinkhost.h"
#include "olink/remoteregistry.h"
#include <memory>

#include <iostream>

// You can run this server app together with the client side app - either also example,
// or implemented olink client (may be using other technology) to play around with it.
// Have in mind, that this example only instantiates the interfaces and the services.
// To see results make sure the clients are sending request to server or add some actions by yourself.
// Note that the server should be started before the client apps.
// If you are running this example from qt creator make sure that the run project settings have "run in terminal" option selected.

int main(int argc, char *argv[]){

    QCoreApplication app(argc, argv);  ApiGear::ObjectLink::RemoteRegistry registry;
    ApiGear::ObjectLink::OLinkHost server(registry);
    server.listen("localhost", 8182);

    {{- range.System.Modules }}
    {{- $module := . }}
    {{- range $module.Interfaces }}
    {{- $interface := . }}
    {{- $class := Camel $interface.Name }}
    {{- $modulePrefix := lower1 (Camel $module.Name)}}
    {{- $instanceName := printf "%s%s"  $modulePrefix $class }}
    {{- $serviceInstanceName := printf "%sOlink%sService" $modulePrefix $class }}
    auto {{$instanceName}} = std::make_shared<{{ snake $module.Name }}::{{$class}}>();
    {{- if $features.monitor }}
    {{ snake $module.Name }}::{{$class}}Traced {{$instanceName}}Traced({{$instanceName}} );
    auto {{$serviceInstanceName}} = std::make_shared< {{- snake $module.Name }}::OLink{{$interface.Name}}Adapter>(registry, &{{ $instanceName }}Traced);
    {{- else}}
    auto {{$serviceInstanceName}} = std::make_shared< {{- snake $module.Name }}::OLink{{$interface.Name}}Adapter>(registry, {{ $instanceName }}.get());
    {{- end }}
    registry.addSource( {{- $serviceInstanceName }});
    {{- end }}
    {{- end }}

    auto result = app.exec();
    // Use the server.

    {{- range.System.Modules }}
    {{- $module := . }}
    {{- range $module.Interfaces }}
    {{- $interface := . }}
    {{- $class := Camel $interface.Name }}
    {{- $modulePrefix := lower1 (Camel $module.Name)}}
    {{- $serviceInstanceName := printf "%sOlink%sService" $modulePrefix $class }}
    registry.removeSource( {{- $serviceInstanceName }}->olinkObjectName());
    {{- end }}
    {{- end }}
    return result;
}
