import { FaSun, FaMoon } from "react-icons/fa";
import type { ThemeProps } from "../theme";

interface Props {
  tema: ThemeProps;
  temaEscuro: boolean;
  alternarTema: () => void;
}

interface NavButtonProps {
  titulo: string;
  alvoId: string;
  tema: ThemeProps;
}

function NavButton({ titulo, alvoId, tema }: NavButtonProps) {
  return (
    <button
      className={`${tema.text}`}
      onClick={() =>
        document.getElementById(alvoId)?.scrollIntoView({ behavior: "smooth" })
      }
    >
      {titulo}
    </button>
  );
}

export default function Header({ tema, temaEscuro, alternarTema }: Props) {
  return (
    <header
      className={`fixed top-0 left-0 w-full z-50 backdrop-blur-md bg-opacity-80 shadow-md transition-colors ${tema.background}`}
    >
      {" "}
      <div className="max-w-6xl mx-auto px-6 py-4 flex justify-end gap-6 items-center">
        <NavButton titulo="Sobre" alvoId="sobre" tema={tema} />
        <NavButton titulo="Projetos" alvoId="projetos" tema={tema} />
        <NavButton titulo="Contato" alvoId="contato" tema={tema} />
        <div className="flex items-center gap-2">
          {temaEscuro ? (
            <FaSun size={24} color={tema.accent} />
          ) : (
            <FaMoon size={24} color={tema.accent} />
          )}
          <label className="relative inline-flex items-center cursor-pointer">
            <input
              type="checkbox"
              className="sr-only peer"
              checked={temaEscuro}
              onChange={alternarTema}
            />
            <div className="w-11 h-6 bg-gray-300 peer-checked:bg-purple-500 rounded-full transition-all"></div>
            <div className="absolute left-1 top-1 w-4 h-4 bg-white rounded-full peer-checked:translate-x-5 transition-all"></div>
          </label>
        </div>
      </div>
    </header>
  );
}
