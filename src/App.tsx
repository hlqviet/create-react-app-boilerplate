import logo from './logo.svg'

function App() {
  return (
    <div className="text-center">
      <header className="flex flex-col justify-center items-center bg-[#282c34] text-white text-[calc(10px_+_2vmin)] min-h-screen">
        <img
          src={logo}
          className="h-[40vmin] pointer-events-none animate-[spin_20s_linear_infinite] motion-reduce:animate-none"
          alt="logo"
        />
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
        </p>
        <a
          className="text-[#61dafb]"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer">
          Learn React
        </a>
      </header>
    </div>
  )
}

export default App
