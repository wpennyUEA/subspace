%
% Bayesian Neural Network Code, December 2020
%
% For "Multitask Learning over Shared Subspace" submitted to 
% PLoS Computational Biology
%
% Nicho Menghi and Will Penny, 
% School of Psychology, 
% University of East Anglia, UK.
%
% These scripts and functions require the following directories
% on your search path. These are also distributed in this archive
%
% ../spm-stats              Stats and other routines
% ../classic-stats          Wrappers for simple statistical tests
%
% -------------------------------------------------------------------------
%
% batch_transfer_expt.m         - Between-task results in paper
% transfer_expt.m               - called by batch_transfer_expt
%
% -------------------------------------------------------------------------
%
% demo_bnn.m                    - Single run of basic model
% demo_bnn_transfer.m           - Single run of model fitted sequentially
%                                 to two tasks
% demo_bnn_mappings.m           - Get typical accuracy on each mapping
% 
% -------------------------------------------------------------------------
% 
% bnn                            - Forward and Backward Pass through network
% bnn_actfun                     - Compute activation function 
% bnn_actfun_deriv               - Compute activation function derivative
% bnn_agent                      - Compute decisions made and reward received by bnn agent
% bnn_augment_fixed              - Create augmented parameter values from old and new
% bnn_augment_net                - Create augmented parameter values from old and new
% bnn_default_opt                - Default optimisation parameters
% bnn_default_params             - Return default parameters
% bnn_distance                   - Compute distance between two densities (KL without post entropy)
% bnn_epc                        - Compute expected probability of being correct 
% bnn_fixparams                  - Fix parameters to chosen values using hard prior
% bnn_fwd                        - Forward pass through MLP
% bnn_indices                    - Get indices of vectorised parameters for each network unit
% bnn_init                       - Initialise new Bayes neural net (bnn)
% bnn_init_fixed                 - Initialise second (augmented) neural net - no new first layer units
% bnn_init_net2                  - Initialise second (augmented) neural net
% bnn_kl_profile                 - Compute KL between prior and posterior for each network unit
% bnn_logjoint                   - Compute LogJoint and derivative from vectorised params
% bnn_loglike                    - Compute log-likelihood from vectorised params
% bnn_mod_output                 - Compute moderated output
% bnn_opt                        - Find MAP parameters allowing for multiple restarts
% bnn_opt_online                 - Find MAP parameters using online gradient ascent of Log Joint
% bnn_opt_single                 - Find MAP parameters using gradient ascent of Log Joint
% bnn_pack                       - Pack parameters into vector 
% bnn_sample                     - Sample from prior
% bnn_tune_alpha                 - Compute negative Log Joint for given step size and gradient
% bnn_unpack                     - Unpack vectorised parameters into structure format
% old_code_from_demo_bnn         - opt.alg='FixedStepSize';
% orth_vectors                   - Orthognalise y with respect to x
% plot_data_map                  - Plot reward probabilities evident in data set
% plot_learnt_maps               - Plot learnt maps
% plot_map                       - Plot Reward Probability Map
