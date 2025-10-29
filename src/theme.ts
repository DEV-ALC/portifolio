export interface ThemeProps {
    background: string;
    text: string;
    card: string;
    gradient: string;
    accent: string;
}

export const lightTheme = {
    name: "light",
    background: "bg-blue-100",
    text: "text-gray-900",
    card: "bg-white text-gray-900",
    gradient: "from-cyan-500 to-blue-300",
    accent: "text-cyan-500",
};

export const darkTheme = {
    name: "dark",
    background: "bg-gray-900",
    text: "text-gray-100",
    card: "bg-gray-800 text-gray-200",
    gradient: "from-purple-900 to-blue-purple-100",
    accent: "text-purple-500",
};
