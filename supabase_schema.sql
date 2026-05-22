-- Script de criação de tabelas para o banco de dados Supabase
-- Copie e execute este script no SQL Editor do seu projeto Supabase.

-- 1. Tabela de Clientes
CREATE TABLE public.clientes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    cpf TEXT UNIQUE NOT NULL,
    nome TEXT NOT NULL,
    data_nascimento DATE,
    observacao TEXT,
    ativo BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Tabela de Produtos
CREATE TABLE public.produtos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nome TEXT NOT NULL,
    preco NUMERIC(10, 2) NOT NULL,
    descricao TEXT,
    categoria TEXT,
    ativo BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. Tabela de Comandas
CREATE TABLE public.comandas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    cliente_id UUID REFERENCES public.clientes(id) ON DELETE SET NULL,
    codigo_qr TEXT UNIQUE NOT NULL,
    valor_atual NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    limite_credito NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    status TEXT NOT NULL DEFAULT 'Pendente' CHECK (status IN ('Pendente', 'Ativa', 'Paga', 'Cancelada')),
    itens_consumidos TEXT[] DEFAULT '{}'::TEXT[] NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Habilitar RLS (Row Level Security) - opcional, dependendo da necessidade de autenticação
-- ALTER TABLE public.clientes ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE public.produtos ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE public.comandas ENABLE ROW LEVEL SECURITY;

-- Exemplo de inserção de produtos para teste (Cardápio inicial)
INSERT INTO public.produtos (nome, preco, descricao, categoria) VALUES
('Dose de Vodka', 15.00, 'Dose clássica de vodka importada', 'Bebidas'),
('Energético Monster', 12.00, 'Lata de energético Monster 473ml', 'Bebidas'),
('Cerveja Heineken Long Neck', 9.50, 'Garrafa long neck 330ml', 'Bebidas'),
('Porção de Batata Frita', 25.00, 'Batata frita crocante com queijo e bacon', 'Comidas'),
('Hambúrguer Artesanal', 30.00, 'Pão brioche, blend 150g, queijo cheddar e molho especial', 'Comidas');
