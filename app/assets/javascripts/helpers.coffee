Em.Handlebars.helper 'money', (value, options) ->
  parts = value.toString().split(".")
  parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, " ")
  parts.join "."