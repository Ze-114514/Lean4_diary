import Mathlib
-- Type
-- #check

-- 处理等式和不等式的 Tactic
  -- rw 相当于自然语言中对算式进行恒等变换
  -- calc 一种对算式进行恒等变换的更方便的格式，可以完成“自然语言中写下一个算式后，使用一连串等号或者不等号进行计算的过程”
    example : (a + b) * (a + b) = a * a + 2 * (a * b) + b * b :=
      calc
        (a + b) * (a + b) = a * a + b * a + (a * b + b * b) := by
          rw [mul_add, add_mul, add_mul]
        _ = a * a + (b * a + a * b) + b * b := by
          rw [← add_assoc, add_assoc (a * a)]
        _ = a * a + 2 * (a * b) + b * b := by
          rw [mul_comm b a, ← two_mul]

  -- ring 提供环结构的公理并自动进行计算
    -- practice 利用环的公理证明环的简单运算性质

  -- rfl

  -- apply 通过 apply 一个定理，可以把这个定理的结论和我们要证明的结论比较，并且用被 apply 的定理的条件作为新的目标
  -- exact 当某个定理可以直接解决我们的结论时，exact 这个定理
  -- linarith
  -- apply?

-- 处理 ∀ ∃ 的 Tactic
  -- ∀
    -- intro
      def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop :=
        ∀ x, f x ≤ a

      example (hfa : FnUb f a) (hgb : FnUb g b) : FnUb (fun x ↦ f x + g x) (a + b) := by
        intro x
        dsimp
        apply add_le_add
        apply hfa
        apply hgb
  -- ∃
    -- use 给一个存在性命题传入一个参数，也就是说用 use 可以通过构造的方式给出存在性证明
      example : ∃ x : ℝ, 2 < x ∧ x < 3 := by
        use 5 / 2 -- 5 / 2 被代入到 x 中
        norm_num

-- 其他 Tactic
  -- have 用于构造一个引理
    example : ∃ x : ℝ, 2 < x ∧ x < 3 := by
      have h1 : 2 < (5 : ℝ) / 2 := by norm_num
      have h2 : (5 : ℝ) / 2 < 3 := by norm_num
      use 5 / 2, h1, h2
  -- rcases 可以从一个证明中解包出一些东西，比如参数、命题
    /-
      rcases a_proof with ⟨a, b⟩
      这样就相应地把这个 a_proof 中的第一个「东西」命名为 a, 第二个「东西」命名为 b
    -/
    variable {α : Type*} [CommRing α]
    def SumOfSquares (x : α) :=
      ∃ a b, x = a ^ 2 + b ^ 2

    theorem sumOfSquares_mul {x y : α} (sosx : SumOfSquares x) (sosy : SumOfSquares y) :
        SumOfSquares (x * y) := by
      rcases sosx with ⟨a, b, xeq⟩
      rcases sosy with ⟨c, d, yeq⟩
      rw [xeq, yeq]
      use a * c - b * d, a * d + b * c
      ring
  -- obtain 一种解包方法
  -- cases
  -- match
