import type { ThemeProps } from "../theme";
import { FaEnvelope, FaGithub, FaLinkedin } from "react-icons/fa";

interface SectionProps {
  tema: ThemeProps;
}

interface SocialButtonProps {
  icon: React.ReactNode;
  text: string;
  url: string;
  tema: ThemeProps;
}

const SocialButton: React.FC<SocialButtonProps> = ({
  icon,
  text,
  url,
  tema,
}) => {
  return (
    <button
      onClick={() => window.open(url, "_blank")}
      className={`flex items-center gap-2 px-4 py-3 rounded-md  transition-transform transform hover:scale-105 ${tema.card}`}
    >
      <span className={`${tema.text} text-xl`}>{icon}</span>
      <span className={`${tema.text} text-sm`}>{text}</span>
    </button>
  );
};

export default function ContatoSection({ tema }: SectionProps) {
  return (
    <section
      id="contato"
      className={`${tema.card} py-20 px-8 transition-colors`}
    >
      <h2 className={`text-3xl font-bold mb-8 text-center ${tema.text}`}>
        Informações de Contato
      </h2>

      <p className={`max-w-3xl mx-auto text-center text-lg ${tema.text}`}>
        Gostaria de trabalhar comigo ou saber mais sobre meus projetos?
      </p>
      <p className={`max-w-3xl mx-auto text-center text-lg ${tema.text}`}>
        Envie uma mensagem!
      </p>

      <div className="mt-10 flex flex-wrap justify-center gap-6">
        <SocialButton
          icon={<FaEnvelope />}
          text="henriquesantos1703m@gmail.com"
          url="mailto:henriquesantos1703m@gmail.com"
          tema={tema}
        />
        <SocialButton
          icon={<FaLinkedin />}
          text="LinkedIn"
          url="https://linkedin.com/in/henrique-3967a418a"
          tema={tema}
        />
        <SocialButton
          icon={<FaGithub />}
          text="github.com/DEV-ALC"
          url="https://github.com/DEV-ALC"
          tema={tema}
        />
      </div>
    </section>
  );
}
