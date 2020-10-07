#####
##### Hyperparameters
#####
Network = ResNet

netparams = ResNetHP(
  num_filters=128,
  num_blocks=15,
  conv_kernel_size=(3, 3),
  num_policy_head_filters=256,
  num_value_head_filters=256,
  batch_norm_momentum=0.1)

self_play = SelfPlayParams(
  num_games=1000,
  reset_mcts_every=1,
  mcts=MctsParams(
    use_gpu=true,
    num_workers=32,
    num_iters_per_turn=500,
    cpuct=3.0,
    prior_temperature=0.7,
    temperature=PLSchedule([0, 12], [1.0, 0.1]),
    dirichlet_noise_ϵ=0.25,
    dirichlet_noise_α=0.75))

arena = ArenaParams(
  num_games=400,
  reset_mcts_every=1,
  flip_probability=0.1,
  update_threshold=1.0,
  play_swiss_style=true,
  mcts=MctsParams(
    self_play.mcts,
    temperature=ConstSchedule(0.2),
    dirichlet_noise_ϵ=0.05))

learning = LearningParams(
  use_gpu=true,
  use_position_averaging=true,
  samples_weighing_policy=LOG_WEIGHT,
  batch_size=256,
  loss_computation_batch_size=256,
  optimiser=Adam(lr=1e-3),
  l2_regularization=1e-4,
  nonvalidity_penalty=1.,
  min_checkpoints_per_epoch=1,
  max_batches_per_checkpoint=8000,
  num_checkpoints=1)

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
  [      0,        100],
  [200_000, 1_000_000]))

#####
##### Benchmarks
#####

mcts_baseline =
  Benchmark.MctsRollouts(
    MctsParams(
      arena.mcts,
      num_iters_per_turn=1000,
      num_workers=1,
      cpuct=1.))

minmax_baseline = Benchmark.MinMaxTS(depth=5, amplify_rewards=true, τ=0.2)

solver_baseline = Benchmark.Solver()

players = [
  Benchmark.Full(arena.mcts),
  Benchmark.Full(arena.mcts),
  Benchmark.Full(arena.mcts),
  Benchmark.NetworkOnly(τ=0.5, use_gpu=true)]

baselines = [
  #solver_baseline,
  mcts_baseline,
  minmax_baseline,
  mcts_baseline]

make_duel(player, baseline) =
  Benchmark.Duel(
    player,
    baseline,
    num_games=200,
    flip_probability=0.1,
    color_policy=ALTERNATE_COLORS,
    play_swiss_style=true)

benchmark = [make_duel(p, b) for (p, b) in zip(players, baselines)]
