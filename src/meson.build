whatsmyip2_sources = [
  'main.vala',
  'window.vala',
  'settingsWindow.vala',
  'analyzeOtherWindow.vala',
  'settings.vala',
]

whatsmyip2_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
  dependency('libsoup-2.4'),
  dependency('json-glib-1.0'),
]

gnome = import('gnome')

whatsmyip2_sources += gnome.compile_resources('whatsmyip2-resources',
  'whatsmyip2.gresource.xml',
  c_name: 'whatsmyip2'
)

executable('whatsmyip2', whatsmyip2_sources,
  vala_args: '--target-glib=2.50',  dependencies: whatsmyip2_deps,
  install: true,
)
