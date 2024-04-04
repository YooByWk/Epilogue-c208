import './App.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Select from "./Select";
import WillApplyWitness from './WillApplyWitness';
import WillViewViewer from './WillViewViewer';
import Will from './Will';
import Logs from './Logs';


function App() {
  return (
    <>
    <BrowserRouter>
    <Routes>
      <Route path='home' element={<Select />} />
      <Route path="/" element={<Select />} />
      <Route path="/witness" element={<WillApplyWitness />} />
      <Route path='/viewer' element={<WillViewViewer />} />
      <Route path='/will' element={<Will />} />
      <Route path='/logs' element={<Logs />} />
      <Route path="/will/:userId" element= {<Will />} />
    </Routes>
    </BrowserRouter>
    </>
  );
}

export default App;
