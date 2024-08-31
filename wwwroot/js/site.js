document.addEventListener('DOMContentLoaded', () => {
    const apiUrl = '/api/viagens';

    // Função para listar viagens
    function listarViagens() {
        fetch(apiUrl)
            .then(response => response.json())
            .then(data => {
                const lista = document.getElementById('viagens-lista');
                lista.innerHTML = '';
                data.forEach(viagem => {
                    const item = document.createElement('li');
                    item.textContent = `ID: ${viagem.id}, Quilometragem: ${viagem.quilometragem}, Motorista: ${viagem.motorista}, Cidade Destino: ${viagem.cidadeDestino}`;
                    lista.appendChild(item);
                });
            })
            .catch(error => console.error('Erro ao listar viagens:', error));
    }

    // Função para adicionar uma nova viagem
    function adicionarViagem() {
        const quilometragem = document.getElementById('quilometragem').value;
        const motorista = document.getElementById('motorista').value;
        const cidadeDestino = document.getElementById('cidadeDestino').value;
        const urlFoto = document.getElementById('urlFoto').value;

        fetch(apiUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                quilometragem: parseFloat(quilometragem),
                motorista: motorista,
                cidadeDestino: cidadeDestino,
                urlFoto: urlFoto
            })
        })
            .then(response => {
                if (response.ok) {
                    alert('Viagem adicionada com sucesso!');
                    listarViagens();
                } else {
                    alert('Erro ao adicionar viagem.');
                }
            })
            .catch(error => console.error('Erro ao adicionar viagem:', error));
    }

    // Configura o botão de adicionar viagem
    document.getElementById('adicionar-btn').addEventListener('click', adicionarViagem);

    // Lista as viagens ao carregar a página
    listarViagens();
});
