import { useState } from "react";
import type { ThemeProps } from "../theme";

interface ProjectCardProps {
  nome: string;
  descricao: string;
  link: string;
  tema: ThemeProps;
}

export function ProjectCard({ nome, descricao, link, tema }: ProjectCardProps) {
  const [hovered, setHovered] = useState(false);

  return (
    <div
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
      className={`w-[320px] p-6 rounded-xl shadow-lg transform transition-all duration-300 cursor-pointer ${tema.card}`}
      style={{
        transform: hovered ? "scale(1.05)" : "scale(1)",
        boxShadow: hovered
          ? "0 6px 20px rgba(0,0,0,0.4)"
          : "0 4px 10px rgba(0,0,0,0.2)",
        background: hovered
          ? `linear-gradient(to bottom right, var(--tw-gradient-stops))`
          : undefined,
      }}
    >
      <h3 className={`text-xl font-semibold mb-3 ${tema.text}`}>{nome}</h3>
      <p className={`text-sm mb-4 ${tema.text}`}>{descricao}</p>

      {link && (
        <button
          onClick={() => window.open(link, "_blank")}
          className={`mt-2 px-4 py-2 rounded-md font-medium transition-colors ${tema.accent}`}
        >
          Ver Projeto →
        </button>
      )}
    </div>
  );
}
