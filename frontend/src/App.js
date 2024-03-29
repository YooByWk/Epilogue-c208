import './App.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Select from "./Select";
import WillApplyWitness from './WillApplyWitness';

function App() {
  return (
    <>
    <BrowserRouter>
    <Routes>
      <Route path='home' element={<Select />} />
      <Route path="/" element={<Select />} />
      <Route path="/witness" element={<WillApplyWitness />} />
    </Routes>
    </BrowserRouter>
    </>
  );
}

export default App;
