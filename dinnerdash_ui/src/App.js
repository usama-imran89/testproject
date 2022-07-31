import './App.css';
import React from 'react';
import axios from "axios"

function App() {
  const [albums, setAlbums] = React.useState([]);
  React.useEffect(()=>{
    axios.get("http://localhost:3000/categories.json")
    .then((res)=>setAlbums(res.data.cat))
    .catch(err=>console.log(err))
  },[])
  return (
    <div className="App">
      <h2>Items:</h2>

      <div>
        {albums.map((item,_) => {
        return (
            <div>
              {item.id}. {item.name}. <img src= {item.avatar} width={250} height={250} ></img>
            </div>
        )
        })}
      </div>

    </div>
  );
}

export default App;
