import type { ThemeProps } from "../theme";
import { ProjectCard } from "./ProjetoCard";

interface Projeto {
  nome: string;
  descricao: string;
  link: string;
}

interface SectionProps {
  tema: ThemeProps;
}

export default function ProjetosSection({ tema }: SectionProps) {
  const projetos: Projeto[] = [
    {
      nome: "Carteira Despesas",
      descricao:
        "Aplicação Mobile, com foco em dashboard de despesas, offline/online",
      link: "https://github.com/DEV-ALC/mywallet",
    },
    {
      nome: "Backend Sincronização offline",
      descricao: "API backend para sincronização com banco/Autentificação JWT",
      link: "https://github.com/DEV-ALC/api_mywallet",
    },
    {
      nome: "Cardápio comercial",
      descricao:
        "Sistema de gestão para restaurantes, incluindo cadastro de produtos, cardápio e pedidos. Voltado também para soft-houses e revendas.",
      link: "https://github.com/DEV-ALC/cardapio",
    },
    {
      nome: "Backend Cardápio",
      descricao:
        "Servidor TypeScript, projetado para servir via wrangles (Cloudflare), autenticação JWT",
      link: "https://github.com/DEV-ALC/api-cardapio",
    },
    {
      nome: "AgroRegistro",
      descricao:
        "Projeto fullstack, React e TypeScript. CRUD de Agricultores, com interface responsiva",
      link: "https://github.com/DEV-ALC/AgroRegisto",
    },
    {
      nome: "Automação Comercial",
      descricao:
        "Sistema de automação comercial com cadastros de vendas, gerenciamento de comandas, checkout e pagamentos, disponível para desktop e mobile.",
      link: "",
    },
    {
      nome: "Automação Comercial Balança",
      descricao:
        "Sistema de automação comercial integrado à balança, com suporte a impressoras e autoatendimento.",
      link: "",
    },
    {
      nome: "Conversor WebP em Go",
      descricao:
        "API escrita em Go para conversão de imagens para WebP, executando em container Docker. Projeto inclui testes de carga com K6 para análise de throughput, latência e estabilidade sob alto volume de requisições.",
      link: "",
    },
  ];

  return (
    <section
      id="projetos"
      className={`${tema.background} py-20 px-8 transition-colors`}
    >
      <h2 className={`text-3xl font-bold mb-12 text-center ${tema.text}`}>
        Projetos
      </h2>

      <div className="flex flex-wrap justify-center gap-8">
        {projetos.map((p) => (
          <ProjectCard
            key={p.nome}
            nome={p.nome}
            descricao={p.descricao}
            link={p.link}
            tema={tema}
          />
        ))}
      </div>
    </section>
  );
}
