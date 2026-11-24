# Taskly

Aplicativo de organização de tarefas implementado em **Flutter** a partir do protótipo criado no Figma.
O foco do trabalho é a interface e a navegação entre as telas, por isso não há backend: os dados ficam em memória.

## Links

- Protótipo original (Figma): https://www.figma.com/design/WHXEhpNjhAkeoWTPveAkoo/Untitled?node-id=0-1
- Documento de apresentação (explica cada tela, a navegação e o código): https://claude.ai/artifact/XuhMPNw9Gtwkj1XBzexJw2
- Repositório: https://github.com/GabrielaFabianpc/taskly

## Telas implementadas

| Tela | Arquivo | O que faz |
| --- | --- | --- |
| Login | `lib/screens/login_screen.dart` | E-mail, senha com mostrar/ocultar e acesso ao cadastro |
| Cadastro | `lib/screens/register_screen.dart` | Formulário de criação de conta |
| Home | `lib/screens/home_screen.dart` | Saudação, progresso do dia e tarefas de hoje |
| Minhas tarefas | `lib/screens/my_tasks_screen.dart` | Lista agrupada por dia com filtros Todas / Pendentes / Concluídas |
| Categorias | `lib/screens/categories_screen.dart` | Grade com total e concluídas por categoria |
| Perfil | `lib/screens/profile_screen.dart` | Dados da usuária, opções e saída da conta |
| Nova tarefa | `lib/screens/new_task_screen.dart` | Criação e edição de tarefas, com seletor de data e horário |
| Detalhes da tarefa | `lib/screens/task_details_screen.dart` | Informações da tarefa, editar e marcar como concluída |

## Navegação

```
Login ──► Cadastro ──► Home
  │                     ▲
  └─────────────────────┘
Home / Tarefas / Categorias / Perfil  (barra inferior)
Home (+) ou Tarefas (Nova tarefa) ──► Nova tarefa
Card de tarefa ──► Detalhes ──► Editar (Nova tarefa preenchida)
Categoria ──► Tarefas da categoria
Perfil ──► Sair da conta ──► Login
```

- Rotas nomeadas definidas em `lib/main.dart` (nomes em `lib/routes.dart`).
- A barra inferior usa `IndexedStack` em `lib/screens/main_shell.dart`, preservando o estado de cada aba.

## Estrutura

```
lib/
├── data/task_store.dart     # tarefas em memória (ChangeNotifier)
├── models/task.dart         # Task, TaskCategory, TaskPriority
├── screens/                 # telas
├── theme/app_theme.dart     # cores e estilos do protótipo
├── utils/                   # formatação de datas e avisos
└── widgets/                 # componentes reutilizáveis (card, chip, campo...)
```

## Como rodar

```bash
flutter create .        # gera as pastas de plataforma (android, ios, web)
flutter pub get
flutter run -d chrome
```
