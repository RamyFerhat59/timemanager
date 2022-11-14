<template>
  <header class="sticky top-0 bg-weather-primary shadow-xl">
    <Navbar></Navbar>
    <!-- <nav
      class="container flex flex-col sm:flex-row items-center gap-4 text-white py-6"
    >
      <RouterLink :to="{ name: 'home' }">
        <div class="flex items-center gap-3">
          <i class="fa-solid fa-clock"></i>
          <p class="text-2xl">Time Manager</p>
        </div>
      </RouterLink>
      <div class="flex gap-3 flex-1 justify-end">
        <i
          class="fa-solid fa-circle-info text-xl hover:text-weather-secondary duration-150 cursor-pointer"
          @click="toggleModal"
        ></i>
        <i
          class="fa-solid fa-plus text-xl hover:text-weather-secondary duration-150 cursor-pointer"
        ></i>
      </div>
      <dropdown text="UserName">
        <list-group>
          <list-group-item>
            <template #prefix>
              <svg
                class="w-4 h-4 fill-current"
                fill="currentColor"
                viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fill-rule="evenodd"
                  d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-6-3a2 2 0 11-4 0 2 2 0 014 0zm-2 4a5 5 0 00-4.546 2.916A5.986 5.986 0 0010 16a5.986 5.986 0 004.546-2.084A5 5 0 0010 11z"
                  clip-rule="evenodd"
                ></path>
              </svg>
            </template>
            Profile
          </list-group-item>
          <list-group-item>
            <template #prefix>
              <svg
                class="w-4 h-4 fill-current"
                fill="currentColor"
                viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M5 4a1 1 0 00-2 0v7.268a2 2 0 000 3.464V16a1 1 0 102 0v-1.268a2 2 0 000-3.464V4zM11 4a1 1 0 10-2 0v1.268a2 2 0 000 3.464V16a1 1 0 102 0V8.732a2 2 0 000-3.464V4zM16 3a1 1 0 011 1v7.268a2 2 0 010 3.464V16a1 1 0 11-2 0v-1.268a2 2 0 010-3.464V4a1 1 0 011-1z"
                ></path>
              </svg>
            </template>
            Settings
          </list-group-item>
          <list-group-item>
            <template #prefix>
              <svg
                class="w-4 h-4 fill-current"
                fill="currentColor"
                viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fill-rule="evenodd"
                  d="M5 3a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2V5a2 2 0 00-2-2H5zm0 2h10v7h-2l-1 2H8l-1-2H5V5z"
                  clip-rule="evenodd"
                ></path>
              </svg>
            </template>
            Logout
          </list-group-item>
        </list-group>
      </dropdown>
    </nav> -->
  </header>
  <!-- <WeatherSearch /> -->
  <div class="text-black bg-white m-2 p-2 rounded shadow-xl">
    WorkingTime
    <button @click="counter += 1">+1</button>
    <p>{{ counter }}</p>
    <button
      class="transition ease-in-out delay-150 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
      @click="show = !show"
    >
      Toggle
    </button>
    <Transition name="fade">
      <p v-if="show">hello</p>
    </Transition>
    <Bar
      :chart-options="chartOptions"
      :chart-data="chartData"
      :chart-id="chartId"
      :dataset-id-key="datasetIdKey"
      :plugins="plugins"
      :css-classes="cssClasses"
      :styles="styles"
      :width="width"
      :height="height"
    />
    <div class="relative">
      <div
        class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none"
      >
        <svg
          aria-hidden="true"
          class="w-5 h-5 text-gray-500 dark:text-gray-400"
          fill="currentColor"
          viewBox="0 0 20 20"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            fill-rule="evenodd"
            d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z"
            clip-rule="evenodd"
          ></path>
        </svg>
      </div>
      <input
        id="datepicker"
        datepicker
        type="text"
        class="eq-input block w-full pl-10 p-2.5"
        placeholder="Select date"
      />
    </div>
    Modify Working Time of : 30/10/22
    <br />
    <input type="number" value="4" />
    <button class="text-black bg-cyan-500 m-2 p-2 rounded shadow-md">ok</button>
    <br />
    <button
      type="button"
      class="focus:outline-none text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900"
    >
      Delete this working time
    </button>
  </div>
  <li v-for="e in list">
    <div class="text-black bg-white m-2 p-2 rounded shadow-xl">
      {{ e.message }}
      <div v-html="e.html"></div>
      <button class="text-black bg-cyan-500 m-2 p-2 rounded shadow-md">
        ok
      </button>
    </div>
  </li>
  <!-- @close-modal => passer la function close-modal -->
  <!-- :modalActive= => passer l'etat "modalActive" -->
  <BaseModal :modalActive="modalActive" @close-modal="toggleModal">
    <div class="text-black">
      <h1 class="text-2xl mb-1">About:</h1>
      <p class="mb-4">
        The Local Weather allows you to track the current and future weather of
        cities of your choosing.
      </p>
      <h2 class="text-2xl">How it works:</h2>
      <ol class="list-decimal list-inside mb-4">
        <li>Search for your city by entering the name into the search bar.</li>
        <li>
          Select a city within the results, this will take you to the current
          weather for your selection.
        </li>
        <li>
          Track the city by clicking on the "+" icon in the top right. This will
          save the city to view at a later time on the home page.
        </li>
      </ol>

      <h2 class="text-2xl">Removing a city</h2>
      <p>
        If you no longer wish to track a city, simply select the city within the
        home page. At the bottom of the page, there will be am option to delete
        the city.
      </p>
    </div>
  </BaseModal>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Bar } from "vue-chartjs";
import Datepicker from "flowbite-datepicker/Datepicker";
import { RouterLink } from "vue-router";
import BaseModal from "./BaseModal.vue";
import WeatherSearch from "./WeatherSearch.vue";
import { Dropdown, ListGroup, ListGroupItem } from "flowbite-vue";
import { Navbar } from 'flowbite-vue'

let props = defineProps({
  year: String,
  month: String,
  day: String,
});
let emits = defineEmits(["dateSelected"]);
let inputValue = () => {
  return `${props.month}/${props.day}/${props.year}`;
};

onMounted(() => {
  const datePicker = document.getElementById("datepicker");
  datePicker.value = inputValue();
  new Datepicker(datePicker, {
    format: "mm/dd/yyyy",
    minDate: new Date(),
  });
  // Emits a Date Object.
  datePicker.addEventListener("changeDate", (e) => {
    emits("dateSelected", e.detail.date);
  });
});

const list = [
  {
    message: "WorkingTime",
  },
  {
    message: "ClockManager",
    html: "<button>ok</button>",
  },
];
const modalActive = ref(null);
const counter = ref(0);

const toggleModal = () => {
  modalActive.value = !modalActive.value;
};
</script>
<script>
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
} from "chart.js";

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale
);

export default {
  // name: "BarChart",
  components: { Bar },
  props: {
    chartId: {
      type: String,
      default: "bar-chart",
    },
    datasetIdKey: {
      type: String,
      default: "label",
    },
    width: {
      type: Number,
      default: 400,
    },
    height: {
      type: Number,
      default: 400,
    },
    cssClasses: {
      default: "",
      type: String,
    },
    styles: {
      type: Object,
      default: () => {},
    },
    plugins: {
      type: Object,
      default: () => {},
    },
  },
  data() {
    return {
      show: true,
      chartData: {
        labels: ["Week 1"],
        datasets: [
          {
            label: "Monday",
            data: "4",
            backgroundColor: "#427ecf",
          },
          {
            label: "Tuesday",
            data: "3",
            backgroundColor: "#427ecf",
          },
          {
            label: "Wednesday",
            data: "5",
            backgroundColor: "#427ecf",
          },
          {
            label: "Thursday",
            data: "6",
            backgroundColor: "#427ecf",
          },
          {
            label: "Friday",
            data: "7",
            backgroundColor: "#427ecf",
          },
          {
            label: "Saturday",
            data: "3",
            backgroundColor: "#427ecf",
          },
          {
            label: "Sunday",
            data: "2",
            backgroundColor: "#427ecf",
          },
        ],
      },
      chartOptions: {
        responsive: true,
        maintainAspectRatio: false,
      },
    };
  },
};
</script>
<style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 2s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
