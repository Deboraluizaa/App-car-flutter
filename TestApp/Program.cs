using System;
using System.Collections.Generic;

namespace flutter_applicat.TestApp
{
    internal class Program
    {
        static List<Registro> registros = new List<Registro>();

        static void Main(string[] args)
        {
            bool continuar = true;

            Console.WriteLine("Bem-vindo ao sistema de registros de quilometragem!");
            Console.WriteLine("");

            while (continuar)
            {
                Console.Clear();
                Console.WriteLine("Sistema de Registros de Quilometragem");
                Console.WriteLine("1. Adicionar Registro");
                Console.WriteLine("2. Editar Registro");
                Console.WriteLine("3. Excluir Registro");
                Console.WriteLine("4. Listar Registros");
                Console.WriteLine("5. Sair");
                Console.Write("Escolha uma opção: ");

                string escolha = Console.ReadLine();

                switch (escolha)
                {
                    case "1":
                        AdicionarRegistro();
                        break;
                    case "2":
                        EditarRegistro();
                        break;
                    case "3":
                        ExcluirRegistro();
                        break;
                    case "4":
                        ListarRegistros();
                        break;
                    case "5":
                        continuar = false;
                        break;
                    default:
                        Console.WriteLine("Opção inválida. Pressione qualquer tecla para tentar novamente.");
                        Console.ReadKey();
                        break;
                }
            }
        }

        static void AdicionarRegistro()
        {
            Console.Write("Digite o ID do registro: ");
            if (int.TryParse(Console.ReadLine(), out int id))
            {
                Console.Write("Digite a quilometragem: ");
                if (double.TryParse(Console.ReadLine(), out double quilometragem))
                {
                    registros.Add(new Registro { Id = id, Quilometragem = quilometragem });
                    Console.WriteLine("Registro adicionado com sucesso. Pressione qualquer tecla para continuar.");
                }
                else
                {
                    Console.WriteLine("Quilometragem inválida. Pressione qualquer tecla para tentar novamente.");
                }
            }
            else
            {
                Console.WriteLine("ID inválido. Pressione qualquer tecla para tentar novamente.");
            }
            Console.ReadKey();
        }

        static void EditarRegistro()
        {
            Console.Write("Digite o ID do registro a ser editado: ");
            if (int.TryParse(Console.ReadLine(), out int id))
            {
                Registro registro = registros.Find(r => r.Id == id);
                if (registro != null)
                {
                    Console.Write("Digite a nova quilometragem: ");
                    if (double.TryParse(Console.ReadLine(), out double novaQuilometragem))
                    {
                        registro.Quilometragem = novaQuilometragem;
                        Console.WriteLine("Registro atualizado com sucesso. Pressione qualquer tecla para continuar.");
                    }
                    else
                    {
                        Console.WriteLine("Quilometragem inválida. Pressione qualquer tecla para tentar novamente.");
                    }
                }
                else
                {
                    Console.WriteLine("Registro não encontrado. Pressione qualquer tecla para tentar novamente.");
                }
            }
            else
            {
                Console.WriteLine("ID inválido. Pressione qualquer tecla para tentar novamente.");
            }
            Console.ReadKey();
        }

        static void ExcluirRegistro()
        {
            Console.Write("Digite o ID do registro a ser excluído: ");
            if (int.TryParse(Console.ReadLine(), out int id))
            {
#pragma warning disable CS8600 // Converting null literal or possible null value to non-nullable type.
                Registro registro = registros.Find(r => r.Id == id);
#pragma warning restore CS8600 // Converting null literal or possible null value to non-nullable type.
                if (registro != null)
                {
                    registros.Remove(registro);
                    Console.WriteLine("Registro excluído com sucesso. Pressione qualquer tecla para continuar.");
                }
                else
                {
                    Console.WriteLine("Registro não encontrado. Pressione qualquer tecla para tentar novamente.");
                }
            }
            else
            {
                Console.WriteLine("ID inválido. Pressione qualquer tecla para tentar novamente.");
            }
            Console.ReadKey();
        }

        static void ListarRegistros()
        {
            if (registros.Count > 0)
            {
                Console.WriteLine("Registros de Quilometragem:");
                foreach (var registro in registros)
                {
                    Console.WriteLine($"ID: {registro.Id}, Quilometragem: {registro.Quilometragem}");
                }
            }
            else
            {
                Console.WriteLine("Nenhum registro encontrado.");
            }
            Console.WriteLine("Pressione qualquer tecla para continuar.");
            Console.ReadKey();
        }
    }

    class Registro
    {
        public int Id { get; set; }
        public double Quilometragem { get; set; }
    }
}
