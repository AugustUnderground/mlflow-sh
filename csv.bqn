rest ← 1 ⊑ •args
base ← 0 ⊑ •args
#rest ← "./steps.csv"
#base ← "./metrics/169/"
runs ← •file.List base
path ← (∾⋈⟜"/reward.csv")¨(∾base⊸⋈)¨runs
data ← •Flines¨(•file.Exists¨path)/path
envs ← 'E' ∾¨ •Fmt¨(↕≠data)
indx ← {"reward" (⊑∘⊐⟜<)˜ (•BQN¨(','⊸((⊢-˜+`×¬)∘=⊔⊢) 0 ⊑ 𝕩)) } ¨ data
rews ← indx { 𝕨 ⊑¨(•BQN⚇1(','⊸((⊢-˜+`×¬)∘=⊔⊢))¨ 1↓ 𝕩 ) } ¨ data
targ ← { ≠¨(0⊸((⊢-˜+`×¬)∘=⊔⊢)) 𝕩 } ¨ rews
padd ← 1 + (⌈´≠¨targ)⊸↑ ¨ targ
rows ← =⊸{<⎉ 𝕨 ⍉⍟ 𝕨 > 𝕩} padd
mean ← (+´÷≠) ¨ rows
step ← +`mean
line ← step ∾¨ mean ∾¨ rows
stln ← ',' {1⊸↓ ∾𝕨⊸∾¨𝕩}¨(•Fmt⚇0 line)
head ←  ⋈∾(','(1↓·⥊≍˘) (⟨"Step", "Mean"⟩ ∾ envs))
rest •FLines (head ∾ stln)
