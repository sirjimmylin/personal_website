const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    // This includes the forms plugin (for nice inputs)
    require('@tailwindcss/forms'),
    // This includes the aspect-ratio plugin (for images)
    require('@tailwindcss/aspect-ratio'),
    // THIS IS THE KEY ONE for Markdown:
    require('@tailwindcss/typography'),
    // This includes container queries (for responsive cards)
    require('@tailwindcss/container-queries'),
  ]
}