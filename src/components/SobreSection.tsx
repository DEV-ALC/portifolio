import type { ThemeProps } from "../theme";

interface SectionProps {
  tema: ThemeProps;
}

export default function SobreSection({ tema }: SectionProps) {
  return (
    <section id="sobre" className={`${tema.card} py-20 px-8`}>
      <h2 className="text-3xl font-bold mb-8 text-center">Sobre</h2>
      <p className="max-w-3xl mx-auto text-justify text-lg">
        Desenvolvedor Fullstack com foco em TypeScript (React, Next.js, NestJS) e C#.
        Experiência na construção de sistemas do zero e na manutenção de aplicações legadas com alta complexidade de regra de negócio.
        Atuo com APIs, integrações entre sistemas, refatoração de código crítico e ajustes estruturais visando estabilidade e manutenção a longo prazo.
        Perfil técnico, orientado à resolução de problemas e melhoria contínua do código e da arquitetura.
      </p>

      <div className="mt-10 flex flex-wrap justify-center gap-4">
        {["TypeScript","C#","Flutter", "Golang", "SQL", "Oracle", "Docker"].map((skill) => (
          <div
            key={skill}
            className={`px-6 py-3 rounded-lg text-white font-semibold bg-gradient-to-r ${tema.gradient}`}
          >
            {skill}
          </div>
        ))}
      </div>
    </section>
  );
}
