/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
    "./node_modules/flowbite/**/*.js",
  ],
  theme: {
    extend: {
      colors: {
        "weather-primary": "#00668A"
      }
    },
    fontFamily: {
      Roboto: ['Roboto', 'sans-serif'],
    },
    container: {
      padding: "2rem",
      center: true,
    },
    screens: {
      sm: "640px",
      md: "760px",
    }
  },
  plugins: [
    require('flowbite/plugin')
  ]
}