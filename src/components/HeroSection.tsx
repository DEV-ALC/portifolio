import { useEffect, useState } from "react";
import type { ThemeProps } from "../theme";
import imgLocal from "../assets/img.jpg";

interface HeroProps {
  tema: ThemeProps;
}
export default function HeroSection({ tema }: HeroProps) {
  const [fade, setFade] = useState(false);

  useEffect(() => {
    setTimeout(() => setFade(true), 100);
  }, []);

  return (
    <section
      className={`h-[70vh] flex flex-col items-center justify-center text-center px-4 transition-opacity duration-700 ${
        fade ? "opacity-100" : "opacity-0"
      } bg-gradient-to-b ${tema.gradient}`}
    >
      <img
        src={imgLocal}
        className="w-48 h-48 rounded-full shadow-lg border-4 border-white"
        alt="foto de perfil"
      />
      <h1 className="text-5xl font-bold mt-6">Alcemir Henrique</h1>
 <p className="text-lg mt-4 max-w-2xl">
  Desenvolvedor Fullstack com foco em TypeScript, C# e construção de sistemas robustos.
</p>
    </section>
  );
}
