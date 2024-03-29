import './App.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Select from "./Select";
import WillApplyWitness from './WillApplyWitness';
import WillViewViewer from './WillViewViewer';
function App() {
  return (
    <>
    <BrowserRouter>
    <Routes>
      <Route path='home' element={<Select />} />
      <Route path="/" element={<Select />} />
      <Route path="/witness" element={<WillApplyWitness />} />
      <Route path='/viewer' element={<WillViewViewer />} />
    </Routes>
    </BrowserRouter>
    </>
  );
}

export default App;
