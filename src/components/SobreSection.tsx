import type { ThemeProps } from "../theme";

interface SectionProps {
  tema: ThemeProps;
}

export default function SobreSection({ tema }: SectionProps) {
  return (
    <section id="sobre" className={`${tema.card} py-20 px-8`}>
      <h2 className="text-3xl font-bold mb-8 text-center">Sobre</h2>
      <p className="max-w-3xl mx-auto text-justify text-lg">
        Sou desenvolvedor focado em soluções de automação comercial com Flutter,
        integração de hardware (balanças, impressoras térmicas, terminais de
        pagamento) e estudo Go e C# para backend escalável na AWS.
      </p>

      <div className="mt-10 flex flex-wrap justify-center gap-4">
        {["Flutter", "TypeScript", "Golang", "C#", "SQL"].map((skill) => (
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
