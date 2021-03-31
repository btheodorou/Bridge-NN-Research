#####
##### NetParams Options
#####

# baseline_network = ResNetHP(
#   num_filters=128,
#   num_blocks=20,
#   conv_kernel_size=(3, 3),
#   num_policy_head_filters=64,
#   num_value_head_filters=64,
#   batch_norm_momentum=0.1)

# more_filters = ResNetHP(
#   num_filters=256,
#   num_blocks=20,
#   conv_kernel_size=(3, 3),
#   num_policy_head_filters=64,
#   num_value_head_filters=64,
#   batch_norm_momentum=0.1)

# less_filters = ResNetHP(
#   num_filters=64,
#   num_blocks=20,
#   conv_kernel_size=(3, 3),
#   num_policy_head_filters=64,
#   num_value_head_filters=64,
#   batch_norm_momentum=0.1)

# more_blocks = ResNetHP(
#   num_filters=128,
#   num_blocks=30,
#   conv_kernel_size=(3, 3),
#   num_policy_head_filters=64,
#   num_value_head_filters=64,
#   batch_norm_momentum=0.1)

# less_blocks = ResNetHP(
#   num_filters=128,
#   num_blocks=10,
#   conv_kernel_size=(3, 3),
#   num_policy_head_filters=64,
#   num_value_head_filters=64,
#   batch_norm_momentum=0.1)

# more_head_filters = ResNetHP(
#   num_filters=128,
#   num_blocks=20,
#   conv_kernel_size=(3, 3),
#   num_policy_head_filters=128,
#   num_value_head_filters=128,
#   batch_norm_momentum=0.1)

# less_head_filters = ResNetHP(
#   num_filters=128,
#   num_blocks=20,
#   conv_kernel_size=(3, 3),
#   num_policy_head_filters=32,
#   num_value_head_filters=32,
#   batch_norm_momentum=0.1)

# more_batch_momentum = ResNetHP(
#   num_filters=128,
#   num_blocks=20,
#   conv_kernel_size=(3, 3),
#   num_policy_head_filters=64,
#   num_value_head_filters=64,
#   batch_norm_momentum=0.25)

# less_batch_momentum = ResNetHP(
#   num_filters=128,
#   num_blocks=20,
#   conv_kernel_size=(3, 3),
#   num_policy_head_filters=64,
#   num_value_head_filters=64,
#   batch_norm_momentum=0.05)

#####
##### LearningParams Options
#####

# baseline_learning = LearningParams(
#   use_gpu=true,
#   use_position_averaging=true,
#   samples_weighing_policy=LOG_WEIGHT,
#   batch_size=128,
#   loss_computation_batch_size=256,
#   optimiser=CyclicNesterov(
#     lr_base=0.0075,
#     lr_high=0.05,
#     lr_low=0.0025,
#     momentum_high=0.9,
#     momentum_low=0.8),
#   l2_regularization=1e-5,
#   nonvalidity_penalty=1.,
#   min_checkpoints_per_epoch=1,
#   max_batches_per_checkpoint=25000,
#   num_checkpoints=1)

# mom_99 = LearningParams(
#   use_gpu=true,
#   use_position_averaging=true,
#   samples_weighing_policy=LOG_WEIGHT,
#   batch_size=128,
#   loss_computation_batch_size=256,
#   optimiser=CyclicNesterov(
#     lr_base=0.0075,
#     lr_high=0.05,
#     lr_low=0.0025,
#     momentum_high=0.99,
#     momentum_low=0.8),
#   l2_regularization=1e-5,
#   nonvalidity_penalty=1.,
#   min_checkpoints_per_epoch=1,
#   max_batches_per_checkpoint=25000,
#   num_checkpoints=1)

# mom_97 = LearningParams(
#   use_gpu=true,
#   use_position_averaging=true,
#   samples_weighing_policy=LOG_WEIGHT,
#   batch_size=128,
#   loss_computation_batch_size=256,
#   optimiser=CyclicNesterov(
#     lr_base=0.0075,
#     lr_high=0.05,
#     lr_low=0.0025,
#     momentum_high=0.97,
#     momentum_low=0.8),
#   l2_regularization=1e-5,
#   nonvalidity_penalty=1.,
#   min_checkpoints_per_epoch=1,
#   max_batches_per_checkpoint=25000,
#   num_checkpoints=1)

mom_95 = LearningParams(
  use_gpu=true,
  use_position_averaging=true,
  samples_weighing_policy=LOG_WEIGHT,
  batch_size=128,
  loss_computation_batch_size=256,
  optimiser=CyclicNesterov(
    lr_base=0.0075,
    lr_high=0.05,
    lr_low=0.0025,
    momentum_high=0.95,
    momentum_low=0.8),
  l2_regularization=1e-5,
  nonvalidity_penalty=1.,
  min_checkpoints_per_epoch=1,
  max_batches_per_checkpoint=25000,
  num_checkpoints=1)

# mom_9 = LearningParams(
#   use_gpu=true,
#   use_position_averaging=true,
#   samples_weighing_policy=LOG_WEIGHT,
#   batch_size=128,
#   loss_computation_batch_size=256,
#   optimiser=CyclicNesterov(
#     lr_base=0.0075,
#     lr_high=0.05,
#     lr_low=0.0025,
#     momentum_high=0.9,
#     momentum_low=0.8),
#   l2_regularization=1e-5,
#   nonvalidity_penalty=1.,
#   min_checkpoints_per_epoch=1,
#   max_batches_per_checkpoint=25000,
#   num_checkpoints=1)

# lr_1_0 = LearningParams(
#   use_gpu=true,
#   use_position_averaging=true,
#   samples_weighing_policy=LOG_WEIGHT,
#   batch_size=128,
#   loss_computation_batch_size=256,
#   optimiser=CyclicNesterov(
#     lr_base=0.5,
#     lr_high=1.0,
#     lr_low=0.1,
#     momentum_high=0.9,
#     momentum_low=0.8),
#   l2_regularization=1e-5,
#   nonvalidity_penalty=1.,
#   min_checkpoints_per_epoch=1,
#   max_batches_per_checkpoint=25000,
#   num_checkpoints=1)

# lr_0_5 = LearningParams(
#   use_gpu=true,
#   use_position_averaging=true,
#   samples_weighing_policy=LOG_WEIGHT,
#   batch_size=128,
#   loss_computation_batch_size=256,
#   optimiser=CyclicNesterov(
#     lr_base=0.25,
#     lr_high=0.5,
#     lr_low=0.05,
#     momentum_high=0.9,
#     momentum_low=0.8),
#   l2_regularization=1e-5,
#   nonvalidity_penalty=1.,
#   min_checkpoints_per_epoch=1,
#   max_batches_per_checkpoint=25000,
#   num_checkpoints=1)

# lr_0_25 = LearningParams(
#   use_gpu=true,
#   use_position_averaging=true,
#   samples_weighing_policy=LOG_WEIGHT,
#   batch_size=128,
#   loss_computation_batch_size=256,
#   optimiser=CyclicNesterov(
#     lr_base=0.125,
#     lr_high=0.25,
#     lr_low=0.025,
#     momentum_high=0.9,
#     momentum_low=0.8),
#   l2_regularization=1e-5,
#   nonvalidity_penalty=1.,
#   min_checkpoints_per_epoch=1,
#   max_batches_per_checkpoint=25000,
#   num_checkpoints=1)

# lr_0_1 = LearningParams(
#   use_gpu=true,
#   use_position_averaging=true,
#   samples_weighing_policy=LOG_WEIGHT,
#   batch_size=128,
#   loss_computation_batch_size=256,
#   optimiser=CyclicNesterov(
#     lr_base=0.05,
#     lr_high=0.1,
#     lr_low=0.01,
#     momentum_high=0.9,
#     momentum_low=0.8),
#   l2_regularization=1e-5,
#   nonvalidity_penalty=1.,
#   min_checkpoints_per_epoch=1,
#   max_batches_per_checkpoint=25000,
#   num_checkpoints=1)

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

# baseline_params = Params(
#   arena=arena,
#   self_play=self_play,
#   learning=baseline_learning,
#   num_iters=100,
#   ternary_rewards=false,
#   use_symmetries=true,
#   memory_analysis=MemAnalysisParams(
#     num_game_stages=4),
#   mem_buffer_size=PLSchedule(
#   [      5,        57],
#   [208_000, 1_560_000]))

# mom_99_params = Params(
#   arena=arena,
#   self_play=self_play,
#   learning=mom_97,
#   num_iters=100,
#   ternary_rewards=false,
#   use_symmetries=true,
#   memory_analysis=MemAnalysisParams(
#     num_game_stages=4),
#   mem_buffer_size=PLSchedule(
#   [      5,        57],
#   [208_000, 1_560_000]))

# mom_97_params = Params(
#   arena=arena,
#   self_play=self_play,
#   learning=mom_99,
#   num_iters=100,
#   ternary_rewards=false,
#   use_symmetries=true,
#   memory_analysis=MemAnalysisParams(
#     num_game_stages=4),
#   mem_buffer_size=PLSchedule(
#   [      5,        57],
#   [208_000, 1_560_000]))

mom_95_params = Params(
  arena=arena,
  self_play=self_play,
  learning=mom_95,
  num_iters=100,
  ternary_rewards=false,
  use_symmetries=true,
  memory_analysis=MemAnalysisParams(
    num_game_stages=4),
  mem_buffer_size=PLSchedule(
  [      5,        57],
  [208_000, 1_560_000]))

# mom_9_params = Params(
#   arena=arena,
#   self_play=self_play,
#   learning=mom_9,
#   num_iters=100,
#   ternary_rewards=false,
#   use_symmetries=true,
#   memory_analysis=MemAnalysisParams(
#     num_game_stages=4),
#   mem_buffer_size=PLSchedule(
#   [      5,        57],
#   [208_000, 1_560_000]))

# lr_1_0_params = Params(
#   arena=arena,
#   self_play=self_play,
#   learning=lr_1_0,
#   num_iters=100,
#   ternary_rewards=false,
#   use_symmetries=true,
#   memory_analysis=MemAnalysisParams(
#     num_game_stages=4),
#   mem_buffer_size=PLSchedule(
#   [      5,        57],
#   [208_000, 1_560_000]))

# lr_0_5_params = Params(
#   arena=arena,
#   self_play=self_play,
#   learning=lr_0_5,
#   num_iters=100,
#   ternary_rewards=false,
#   use_symmetries=true,
#   memory_analysis=MemAnalysisParams(
#     num_game_stages=4),
#   mem_buffer_size=PLSchedule(
#   [      5,        57],
#   [208_000, 1_560_000]))

# lr_0_25_params = Params(
#   arena=arena,
#   self_play=self_play,
#   learning=lr_0_25,
#   num_iters=100,
#   ternary_rewards=false,
#   use_symmetries=true,
#   memory_analysis=MemAnalysisParams(
#     num_game_stages=4),
#   mem_buffer_size=PLSchedule(
#   [      5,        57],
#   [208_000, 1_560_000]))

# lr_0_1_params = Params(
#   arena=arena,
#   self_play=self_play,
#   learning=lr_0_1,
#   num_iters=100,
#   ternary_rewards=false,
#   use_symmetries=true,
#   memory_analysis=MemAnalysisParams(
#     num_game_stages=4),
#   mem_buffer_size=PLSchedule(
#   [      5,        57],
#   [208_000, 1_560_000]))

#####
##### Trials
#####

optimal_network = ResNetHP(
  num_filters=256,
  num_blocks=25,
  conv_kernel_size=(3, 3),
  num_policy_head_filters=128,
  num_value_head_filters=128,
  batch_norm_momentum=0.1)

trials = []
push!(trials, (label="opt_params", params=mom_95_params, netparams=optimal_network))
