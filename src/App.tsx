import { useEffect, useState } from "react";
import { lightTheme, darkTheme } from "./theme";
import Header from "./components/Header";
import HeroSection from "./components/HeroSection";
import SobreSection from "./components/SobreSection";
import ProjetosSection from "./components/ProjetosSection";
import ContatoSection from "./components/ContatoSection";

function App() {
  const [temaEscuro, setTemaEscuro] = useState(true);

  // Sincroniza com localStorage após o mount
  useEffect(() => {
    const temaSalvo = localStorage.getItem("tema");
    if (temaSalvo) {
      setTemaEscuro(temaSalvo === "escuro");
    }
  }, []);

  const alternarTema = () => {
    const novoTema = !temaEscuro;
    setTemaEscuro(novoTema);
    localStorage.setItem("tema", novoTema ? "escuro" : "claro");
  };

  const theme = temaEscuro ? darkTheme : lightTheme;

  return (
    <div className={`${theme.background} ${theme.text} min-h-screen`}>
      <Header
        tema={theme}
        temaEscuro={temaEscuro}
        alternarTema={alternarTema}
      />
      <main>
        <HeroSection tema={theme} />
        <SobreSection tema={theme} />
        <ProjetosSection tema={theme} />
        <ContatoSection tema={theme} />
      </main>
    </div>
  );
}

export default App;
