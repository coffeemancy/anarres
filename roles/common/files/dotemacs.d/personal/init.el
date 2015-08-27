;;
;; MANAGED BY CHEF IN wergstation::bashrc RECIPE.
;; CHANGES WILL BE OVERWRITTEN!
;;

;; disable menubar, toolbar, scrollbar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; good defaults
(load-theme 'manoj-dark)
(set-fringe-mode '(1 . 0))
(setq column-number-mode t)
(setq inhibit-startup-message t)
(setq line-number-mode t)
(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)
(setq-default tab-width 2)

;; put backups in a .saves directory
(setq backup-directory-alist '(("." . "~/.saves")))

;; set up package repos
(require 'package)
(setq package-archives
      '(
        ("gnu" . "http://elpa.gnu.org/packages/")
               
        ("marmalade" . "http://marmalade-repo.org/packages/")
               
        ("melpa" . "http://melpa.milkbox.net/packages/")
               
        ("tromey" . "http://tromey.com/elpa/")
               ))
(package-initialize)

;; install packages
(if (not (package-installed-p 'undo-tree))
    (progn
      (package-refresh-contents)
      (package-install 'undo-tree)))
(if (not (package-installed-p 'evil))
    (progn
      (package-refresh-contents)
      (package-install 'evil)))
(if (not (package-installed-p 'git-gutter-fringe))
    (progn
      (package-refresh-contents)
      (package-install 'git-gutter-fringe)))
(if (not (package-installed-p 'markdown-mode))
    (progn
      (package-refresh-contents)
      (package-install 'markdown-mode)))
(if (not (package-installed-p 'nlinum))
    (progn
      (package-refresh-contents)
      (package-install 'nlinum)))
(if (not (package-installed-p 'rainbow-delimiters))
    (progn
      (package-refresh-contents)
      (package-install 'rainbow-delimiters)))
(if (not (package-installed-p 'column-enforce-mode))
    (progn
      (package-refresh-contents)
      (package-install 'column-enforce-mode)))
(if (not (package-installed-p 'ruby-mode))
    (progn
      (package-refresh-contents)
      (package-install 'ruby-mode)))
(if (not (package-installed-p 'inf-ruby))
    (progn
      (package-refresh-contents)
      (package-install 'inf-ruby)))
(if (not (package-installed-p 'ruby-end))
    (progn
      (package-refresh-contents)
      (package-install 'ruby-end)))
(if (not (package-installed-p 'ruby-interpolation))
    (progn
      (package-refresh-contents)
      (package-install 'ruby-interpolation)))
(if (not (package-installed-p 'rhtml-mode))
    (progn
      (package-refresh-contents)
      (package-install 'rhtml-mode)))
(if (not (package-installed-p 'rspec-mode))
    (progn
      (package-refresh-contents)
      (package-install 'rspec-mode)))
(if (not (package-installed-p 'yaml-mode))
    (progn
      (package-refresh-contents)
      (package-install 'yaml-mode)))
(if (not (package-installed-p 'clojure-mode))
    (progn
      (package-refresh-contents)
      (package-install 'clojure-mode)))
(if (not (package-installed-p 'cider))
    (progn
      (package-refresh-contents)
      (package-install 'cider)))
(if (not (package-installed-p 'ess))
    (progn
      (package-refresh-contents)
      (package-install 'ess)))

;; use nlinum for line numbers
(global-nlinum-mode 1)

;; Am I evil? Yes I fucking am.
(require 'undo-tree)
(require 'evil)
(evil-mode 1)
(undo-tree-mode 1)

;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

;; esc quits everything like vim does
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;; use Source Code Pro font
(set-default-font "Source Code Pro Medium-10")

;; use rainbow delimiters
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode t)

;; highlight text past 80 chars
(require 'column-enforcer-mode)
(column-enforcer-mode t)

;; ruby hooks
(require 'ruby-end)
(require 'ruby-interpolation)
(autoload 'ruby-mode "ruby-mode" nil t)
(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'ruby-interpolation-mode)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)
(add-to-list 'auto-mode-alist '("Berksfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Cleaverfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Thorfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" .ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))

;; use pry for inferior Ruby process
(setq inf-ruby-default-implementation "/home/cstedman/.rbenv/shims/pry")

;; rhtml files (e.g. erubis)
(autoload 'rhtml-mode "rhtml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))

;; yaml files
(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; clojure/cider stuff
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
(setq cider-prompt-save-file-on-load nil)
(setq cider-repl-display-in-current-window t)
(setq cider-repl-print-length 100)

;; use some bitching plugins
(require 'git-gutter-fringe)
(global-git-gutter-mode t)

;; (require 'sr-speedbar)
;; (sr-speedbar-open)

;; global keybindings
(global-set-key (kbd "C-x a") 'append-to-buffer)
(global-set-key (kbd "s-x") 'execute-extended-command)

;; fullscreen function
(defun switch-full-screen (&optional ii)
   (interactive "p")
  (if (> ii 0)
      (shell-command "wmctrl -r :ACTIVE: -badd,fullscreen"))
  (if (< ii 0)
      (shell-command "wmctrl -r :ACTIVE: -bremove,fullscreen"))
  (if (equal ii 0)
      (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen")))

;; distraction-free mode
(defun distraction-free-mode ()
	"Make things simple-looking by removing decoration."
        (interactive)
        (switch-full-screen 1)
        (setq left-margin 10)
        (global-nlinum-mode -1)
        (set-fringe-mode '(0 . 0))
        (auto-fill-mode 1))
