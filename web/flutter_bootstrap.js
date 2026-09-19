{{flutter_js}}
{{flutter_build_config}}

// Do not register Flutter's deprecated service worker. HTML, bootstrap and
// app code are revalidated on every load, while index.html handles automatic
// version checks for installed mobile web apps.
_flutter.loader.load();
