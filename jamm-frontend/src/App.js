/*
Project Description: A Fullstack application using Flask as backend, React as Frontend and MySQL as Database
File Description: This file that calls Approutes and it is being called by index.js

*/

import 'antd/dist/antd.css';
import AppRoutes from './AppRoute';

// A function to call AppRoutes
function App() {
  return (
    <>
    <AppRoutes />
  </>
  );
}

// Exporting the AppRoute Component
export default App;
