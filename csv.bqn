rest ← 1 ⊑ •args # "./steps.csv"
base ← 0 ⊑ •args # "../acid-paper/acid/dat/281/"
runs ← •file.List base
path ← (∾⋈⟜"/reward.csv")¨(∾base⊸⋈)¨runs
data ← •Flines¨(•file.Exists¨path)/path
indx ← {"reward" (⊑∘⊐⟜<)˜ (•BQN¨(','⊸((⊢-˜+`×¬)∘=⊔⊢) 0 ⊑ 𝕩)) } ¨ data
rews ← indx { 𝕨 ⊑¨(•BQN⚇1(','⊸((⊢-˜+`×¬)∘=⊔⊢))¨ 1↓ 𝕩 ) } ¨ data
targ ← { ≠¨(0⊸((⊢-˜+`×¬)∘=⊔⊢)) 𝕩 } ¨ rews
maxi ← ⊑∨≠¨targ
padc ← maxi⊸-≠¨targ
zero ← { 𝕩 ⥊ 0 } ¨ padc # coms ← { 𝕩 ⥊ ',' } ¨ padc
fill ← targ∾¨zero       # fill ← line∾¨coms
cols ← <˘⍉>fill
line ← ',' {1⊸↓ ∾𝕨⊸∾¨𝕩}¨(•Fmt⚇0 cols)
head ← ⋈∾(','(1↓·⥊≍˘)runs)
rest •FLines (head ∾ line)
