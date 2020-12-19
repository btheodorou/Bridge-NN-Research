#####
##### NetParams Options
#####

baseline_network = ResNetHP(
  num_filters=128,
  num_blocks=20,
  conv_kernel_size=(3, 3),
  num_policy_head_filters=64,
  num_value_head_filters=64,
  batch_norm_momentum=0.1)

more_filters = ResNetHP(
  num_filters=256,
  num_blocks=20,
  conv_kernel_size=(3, 3),
  num_policy_head_filters=64,
  num_value_head_filters=64,
  batch_norm_momentum=0.1)

less_filters = ResNetHP(
  num_filters=64,
  num_blocks=20,
  conv_kernel_size=(3, 3),
  num_policy_head_filters=64,
  num_value_head_filters=64,
  batch_norm_momentum=0.1)

more_blocks = ResNetHP(
  num_filters=128,
  num_blocks=30,
  conv_kernel_size=(3, 3),
  num_policy_head_filters=64,
  num_value_head_filters=64,
  batch_norm_momentum=0.1)

less_blocks = ResNetHP(
  num_filters=128,
  num_blocks=10,
  conv_kernel_size=(3, 3),
  num_policy_head_filters=64,
  num_value_head_filters=64,
  batch_norm_momentum=0.1)

more_head_filters = ResNetHP(
  num_filters=128,
  num_blocks=20,
  conv_kernel_size=(3, 3),
  num_policy_head_filters=128,
  num_value_head_filters=128,
  batch_norm_momentum=0.1)

less_head_filters = ResNetHP(
  num_filters=128,
  num_blocks=20,
  conv_kernel_size=(3, 3),
  num_policy_head_filters=32,
  num_value_head_filters=32,
  batch_norm_momentum=0.1)

more_batch_momentum = ResNetHP(
  num_filters=128,
  num_blocks=20,
  conv_kernel_size=(3, 3),
  num_policy_head_filters=64,
  num_value_head_filters=64,
  batch_norm_momentum=0.25)

less_batch_momentum = ResNetHP(
  num_filters=128,
  num_blocks=20,
  conv_kernel_size=(3, 3),
  num_policy_head_filters=64,
  num_value_head_filters=64,
  batch_norm_momentum=0.05)

#####
##### LearningParams Options
#####

baseline_learning = LearningParams(
  use_gpu=true,
  use_position_averaging=true,
  samples_weighing_policy=LOG_WEIGHT,
  batch_size=64,
  loss_computation_batch_size=256,
  optimiser=CyclicNesterov(
    lr_base=0.0075,
    lr_high=0.05,
    lr_low=0.0025,
    momentum_high=0.9,
    momentum_low=0.8),
  l2_regularization=1e-4,
  nonvalidity_penalty=1.,
  min_checkpoints_per_epoch=1,
  max_batches_per_checkpoint=25000,
  num_checkpoints=1)

more_lr = LearningParams(
  use_gpu=true,
  use_position_averaging=true,
  samples_weighing_policy=LOG_WEIGHT,
  batch_size=64,
  loss_computation_batch_size=256,
  optimiser=CyclicNesterov(
    lr_base=0.0375,
    lr_high=0.25,
    lr_low=0.0125,
    momentum_high=0.9,
    momentum_low=0.8),
  l2_regularization=1e-4,
  nonvalidity_penalty=1.,
  min_checkpoints_per_epoch=1,
  max_batches_per_checkpoint=25000,
  num_checkpoints=1)

less_lr = LearningParams(
  use_gpu=true,
  use_position_averaging=true,
  samples_weighing_policy=LOG_WEIGHT,
  batch_size=64,
  loss_computation_batch_size=256,
  optimiser=CyclicNesterov(
    lr_base=0.0015,
    lr_high=0.01,
    lr_low=0.0005,
    momentum_high=0.9,
    momentum_low=0.8),
  l2_regularization=1e-4,
  nonvalidity_penalty=1.,
  min_checkpoints_per_epoch=1,
  max_batches_per_checkpoint=25000,
  num_checkpoints=1)

more_lr_momentum = LearningParams(
  use_gpu=true,
  use_position_averaging=true,
  samples_weighing_policy=LOG_WEIGHT,
  batch_size=64,
  loss_computation_batch_size=256,
  optimiser=CyclicNesterov(
    lr_base=0.0075,
    lr_high=0.05,
    lr_low=0.0025,
    momentum_high=0.95,
    momentum_low=0.85),
  l2_regularization=1e-4,
  nonvalidity_penalty=1.,
  min_checkpoints_per_epoch=1,
  max_batches_per_checkpoint=25000,
  num_checkpoints=1)

less_lr_momentum = LearningParams(
  use_gpu=true,
  use_position_averaging=true,
  samples_weighing_policy=LOG_WEIGHT,
  batch_size=64,
  loss_computation_batch_size=256,
  optimiser=CyclicNesterov(
    lr_base=0.0075,
    lr_high=0.05,
    lr_low=0.0025,
    momentum_high=0.7,
    momentum_low=0.5),
  l2_regularization=1e-4,
  nonvalidity_penalty=1.,
  min_checkpoints_per_epoch=1,
  max_batches_per_checkpoint=25000,
  num_checkpoints=1)

more_regularization = LearningParams(
  use_gpu=true,
  use_position_averaging=true,
  samples_weighing_policy=LOG_WEIGHT,
  batch_size=64,
  loss_computation_batch_size=256,
  optimiser=CyclicNesterov(
    lr_base=0.0075,
    lr_high=0.05,
    lr_low=0.0025,
    momentum_high=0.9,
    momentum_low=0.8),
  l2_regularization=1e-3,
  nonvalidity_penalty=1.,
  min_checkpoints_per_epoch=1,
  max_batches_per_checkpoint=25000,
  num_checkpoints=1)

less_regularization = LearningParams(
  use_gpu=true,
  use_position_averaging=true,
  samples_weighing_policy=LOG_WEIGHT,
  batch_size=64,
  loss_computation_batch_size=256,
  optimiser=CyclicNesterov(
    lr_base=0.0075,
    lr_high=0.05,
    lr_low=0.0025,
    momentum_high=0.9,
    momentum_low=0.8),
  l2_regularization=1e-5,
  nonvalidity_penalty=1.,
  min_checkpoints_per_epoch=1,
  max_batches_per_checkpoint=25000,
  num_checkpoints=1)

#####
##### Other Params
#####

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

#####
##### Full Params Options
#####

baseline_params = Params(
  arena=arena,
  self_play=self_play,
  learning=baseline_learning,
  num_iters=100,
  ternary_rewards=false,
  use_symmetries=true,
  memory_analysis=MemAnalysisParams(
    num_game_stages=4),
  mem_buffer_size=PLSchedule(
  [      5,        57],
  [208_000, 1_560_000]))

more_lr_params = Params(
  arena=arena,
  self_play=self_play,
  learning=more_lr,
  num_iters=100,
  ternary_rewards=false,
  use_symmetries=true,
  memory_analysis=MemAnalysisParams(
    num_game_stages=4),
  mem_buffer_size=PLSchedule(
  [      5,        57],
  [208_000, 1_560_000]))

less_lr_params = Params(
  arena=arena,
  self_play=self_play,
  learning=less_lr,
  num_iters=100,
  ternary_rewards=false,
  use_symmetries=true,
  memory_analysis=MemAnalysisParams(
    num_game_stages=4),
  mem_buffer_size=PLSchedule(
  [      5,        57],
  [208_000, 1_560_000]))

more_lr_momentum_params = Params(
  arena=arena,
  self_play=self_play,
  learning=more_lr_momentum,
  num_iters=100,
  ternary_rewards=false,
  use_symmetries=true,
  memory_analysis=MemAnalysisParams(
    num_game_stages=4),
  mem_buffer_size=PLSchedule(
  [      5,        57],
  [208_000, 1_560_000]))

less_lr_momentum_params = Params(
  arena=arena,
  self_play=self_play,
  learning=less_lr_momentum,
  num_iters=100,
  ternary_rewards=false,
  use_symmetries=true,
  memory_analysis=MemAnalysisParams(
    num_game_stages=4),
  mem_buffer_size=PLSchedule(
  [      5,        57],
  [208_000, 1_560_000]))

more_regularization_params = Params(
  arena=arena,
  self_play=self_play,
  learning=more_regularization,
  num_iters=100,
  ternary_rewards=false,
  use_symmetries=true,
  memory_analysis=MemAnalysisParams(
    num_game_stages=4),
  mem_buffer_size=PLSchedule(
  [      5,        57],
  [208_000, 1_560_000]))

less_regularization_params = Params(
  arena=arena,
  self_play=self_play,
  learning=less_regularization,
  num_iters=100,
  ternary_rewards=false,
  use_symmetries=true,
  memory_analysis=MemAnalysisParams(
    num_game_stages=4),
  mem_buffer_size=PLSchedule(
  [      5,        57],
  [208_000, 1_560_000]))

#####
##### Trials
#####

trials = []
push!(trials, (label="baseline", params=baseline_params, netparams=baseline_network))
push!(trials, (label="more_filters", params=baseline_params, netparams=more_filters))
push!(trials, (label="less_filters", params=baseline_params, netparams=less_filters))
push!(trials, (label="more_blocks", params=baseline_params, netparams=more_blocks))
push!(trials, (label="less_blocks", params=baseline_params, netparams=less_blocks))
push!(trials, (label="more_head_filters", params=baseline_params, netparams=more_head_filters))
push!(trials, (label="less_head_filters", params=baseline_params, netparams=less_head_filters))
push!(trials, (label="more_batch_momentum", params=baseline_params, netparams=more_batch_momentum))
push!(trials, (label="less_batch_momentum", params=baseline_params, netparams=less_batch_momentum))
push!(trials, (label="more_lr", params=more_lr_params, netparams=baseline_network))
push!(trials, (label="less_lr", params=less_lr_params, netparams=baseline_network))
push!(trials, (label="more_lr_momentum", params=more_lr_momentum_params, netparams=baseline_network))
push!(trials, (label="less_lr_momentum", params=less_lr_momentum_params, netparams=baseline_network))
push!(trials, (label="more_regularization", params=more_regularization_params, netparams=baseline_network))
push!(trials, (label="less_regularization", params=less_regularization_params, netparams=baseline_network))