# day0

安装 Lean4 以及依赖

## Install VScode and install the extension lean4

## 设置命令行的网络代理

Open the setting:
```bash
nano ~/.bashrc
```

set the setting:
```bash
# Proxy settings for HTTP/HTTPS
export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890
# 有需要时替换成自己的代理端口，其中127.0.0.1为本机地址，7890为监听地址，http和SOCKS5根据代理服务相关设置确定
```

Use ```Ctrl + O + Enter``` to save and ```Ctrl + X``` to exit.

Use ```source ~/.bashrc``` to let the code run.

Close and restart Git Bash, then input
```bash
echo $http_proxy
echo $https_proxy
```
to verify the net.

## clone the repository from remote

Create a folder in disk D and enter. Then opening git bash and input
```bash
git clone https://github.com/leanprover-community/mathematics_in_lean.git
```
to clone the repository of MIL(Mathematics in Lean) from github.

Use ```cd mathematics_in_lean``` to enter this repository.

## Install Lean4 and Mathlib4

Use
```bash
lake exe cache get
```
to install Lean4 and Mathlib4.

# day1

## 类型论

为**对象（Object）**赋予**类型（Type）**，记作 ```a:A```，即 Object a has Type A. Now a is a term/element/instance of A.

```lean
#check a
```

is used to check the Tpye of an Object.

>但是无法 check lean 中的一些语法命令，比如```#chcek```.

```:```用于声明类型，```:=```用于定义。

常见的类型有自然数 **Nat**，而 Nat 在类型论中又为类型 **Type**. **命题证明**的类型为**命题**，命题的类型是**命题类型**。

## 定义对象

```lean
def a : A := sorry
```
## 函数类型

由类型 A，B 可得类型 $A\to B$ 也是类型，称为由 A 类型映射到 B 类型的函数类型 (Function Type). 其元素称为**函数 (Functions)**. $f: A \to B$

函数的 Curry 化

函数的定义

```lean
def f : A \to B := sorry
def f (a : A) : B := sorry

#check f (a) -- B
#check f a -- B
```
## 求值

```lean
#eval 1 + 1 ---2
```

e.g.定义加法函数
```lean
def add1 : \N \to \N := fun n \mspdto n + 1 -- 这个没看懂
def add2 (n : \N) : \N := n + 1
```

## 隐式参数

```lean
def h := add_comm 1 2
#check h
def f (a : ℕ)(b : ℕ)(h : a + b = b + a) : ℕ := a
#eval f _ _ h
def g {a : ℕ} {b} (h : a + b = b + a) : ℕ := a
#eval g h
def g' {a : ℕ} {b} (h : a + b = b + a) : ℕ := a
#check g' (a := 1) (b := 2) sorry
```

## 命题类型

命题类型记作```prop```,其元素为命题,命题的对象为证明.

### 公理1.1 证明具有无关性

### 定理声明

```theorem```及其变体

>```theorem```实际上是一个证明类型的对象?因为他的Type是一个命题.

### 全局变量声明

```lean
-- variable (p q : Prop)
variable {p q r : Prop}
theorem pq : p → q := by sorry --若使用显式变量，需要在定义 pq 时声明所需参数，比如 theorem pq (p q : Prop) : p → q := by sorry
#check pq
theorem sth (hp : p) : q := pq hp
```

## Tactic Proof
```by sorry```

### rw(rewrite)

```h : A = B```,```rq [h]```表示在 goal 中寻找左式并替换成右式.可以使用```at```来指定替换对象,也可以使用反箭头来改变替换方向.

```lean
-- Proof state: (h1 : A) ⊢ A
 rw [h]-- Proof state: (h1 : A) ⊢ B
 rw [h] at h1-- Proof state: (h1 : B) ⊢ B
 rw [← h] at *-- Proof state: (h1 : A) ⊢ A
```

### calc
处理传递的等式和不等式.
```lean
theorem th_name : a = z := by
  calc
    a = b := by sorry
    _ = c := by sorry-- ...
    _ = z := by sorry
```

### others

ring, linarith, simp, norm_num, aesop, #help tactic

### have

切割规则（Cut）：构造一个引理，即为证明 q，只需证明 p，再用 p 证明 q.

```lean
theorem th_name {p : Prop} : q := by
    have hp : p := by sorry
    #check hp
    sorry
```

### constructor

合取右规则（RRoC）：要证明```p ∧ q```，只需分别证明 p, q.

```lean
theorem Conj_constructor (hp : p) (hq : q) : p ∧ q := by
    constructor
    . exact hp
    . exact hq
```

```lean
theorem Conj_refine (hp : p) (hq : q) : p ∧ q := by
    refine ⟨?_, ?_⟩
    . exact hp
    . exact hq
```

LRoC：若 hp 可完成结论的证明，则 (h : p ∧ q) 也可完成结论的证明。

### apply

LRoI：若有 hp，则可用 h : p → q 得到 hq.

```apply``` tactic 来应用蕴含假设。

```lean
theorem Imp_apply (hp : p) (h : p → q) : q := by
    apply h
    exact hp
```

### left / right

RRoD：由 hp 可构造 (h : p ∨ q).

```lean
theorem Disj_left (hp : p) : p ∨ q := by
    left
    exact hp
```

### obtain, rcases

LRoD：为了由 h 得到 hr，只需要由 hp 得到 hr 且 hq 得到 hr.

```obtain``` ```rcases``` 可对析取提供分类讨论

```lean
theorem Disj_obtain (h : p ∨ q)(pr : p → r)(qr : q → r): r := by
    obtain hp | hq := h
    . exact pr hp
    . exact qr hq
```

### intro

RRoUQ：为证明 ∀ x ：α, p x，用 intro 取出一个特定的 x，再由 (hp : p a) 完成证明。

### use

### case



## 一阶形式逻辑

### 一阶逻辑算子
蕴含,等价,合取,析取,否定,谓词,全称量化,存在量化

```namespace```

