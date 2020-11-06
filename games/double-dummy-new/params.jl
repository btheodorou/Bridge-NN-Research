#####
##### Hyperparameters
#####
Network = ResNet

netparams = ResNetHP(
  num_filters=128,
  num_blocks=20,
  conv_kernel_size=(3, 3),
  num_policy_head_filters=64,
  num_value_head_filters=64,
  batch_norm_momentum=0.1)

self_play = SelfPlayParams(
  num_games=1000,
  reset_mcts_every=1,
  mcts=MctsParams(
    use_gpu=true,
    num_workers=32,
    num_iters_per_turn=1000,
    cpuct=4.0,
    prior_temperature=0.7,
    temperature=PLSchedule([0, 24], [1.0, 0.5]),
    dirichlet_noise_ϵ=0.25,
    dirichlet_noise_α=1.25))

arena = ArenaParams(
  num_games=2,
  reset_mcts_every=1,
  flip_probability=0.1,
  update_threshold=0.5,
  play_swiss_style=true,
  mcts=MctsParams(
    self_play.mcts,
    temperature=ConstSchedule(0.2),
    dirichlet_noise_ϵ=0.05))

learning = LearningParams(
  use_gpu=true,
  use_position_averaging=true,
  samples_weighing_policy=LOG_WEIGHT,
  batch_size=64,
  loss_computation_batch_size=256,
  optimiser=CyclicNesterov(
    lr_base=0.015,
    lr_high=0.15,
    lr_low=0.01,
    momentum_high=0.9,
    momentum_low=0.8),
  l2_regularization=1e-4,
  nonvalidity_penalty=1.,
  min_checkpoints_per_epoch=1,
  max_batches_per_checkpoint=25000,
  num_checkpoints=2)

params = Params(
  arena=arena,
  self_play=self_play,
  learning=learning,
  num_iters=100,
  ternary_rewards=false,
  use_symmetries=true,
  memory_analysis=MemAnalysisParams(
    num_game_stages=4),
  mem_buffer_size=PLSchedule(
  [      5,        57],
  [208_000, 1_560_000]))

#####
##### Benchmarks
#####

# mcts_baseline =
#   Benchmark.MctsRollouts(
#     MctsParams(
#       arena.mcts,
#       num_iters_per_turn=1000,
#       num_workers=1,
#       cpuct=1.))

# minmax_baseline = Benchmark.MinMaxTS(depth=5, amplify_rewards=true, τ=0.2)

solver_baseline = Benchmark.Solver(ϵ=0)

players = [
  Benchmark.Full(arena.mcts),
  Benchmark.NetworkOnly(τ=0.25, use_gpu=true)]

baselines = [
  solver_baseline,
  solver_baseline]

make_duel(player, baseline) =
  Benchmark.Duel(
    player,
    baseline,
    num_games=150,
    flip_probability=0.1,
    color_policy=ALTERNATE_COLORS,
    play_swiss_style=true)

benchmark = [make_duel(p, b) for (p, b) in zip(players, baselines)]
