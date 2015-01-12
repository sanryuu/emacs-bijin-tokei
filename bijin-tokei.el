;;; package --- 
;;; Commentary:
;;; Code:

(defvar bijin-tokei-last-display-time ""
  "美人時計の最終アップデート時間")

(defvar bijin-tokei-timer nil
  "美人時計の定期実行用のタイマー")

(defvar bijin-tokei-url-prefix
  "http://www.bijint.com/"
  "美人時計のURLのプレフィクス")

(defcustom bijin-tokei-genre
  "jp"
  "美人時計のジャンル")

(defvar bijin-tokei-url-mid
  "/tokei_images/"
  "美人時計のURLの中間部品")

(defvar bijin-tokei-url-postfix ".jpg"
  "美人時計のURLのポストフィックス(拡張子)")

(defvar bijin-tokei-genre-list (list
                                "jp"
                                "osaka"
                                "nagasaki"
                                "kanazawa"
                                "hiroshima"
                                "kagawa"
                                "tochigi"
                                "fukui"
                                "akita"
                                "gumma"
                                "chiba"
                                "hokkaido"
                                "kobe"
                                "niigata"
                                "kanagawa"
                                "binan")
  "美人時計のジャンルのリスト")

(defun bijin-tokei-start ()
  "美人時計の開始"
  (interactive)
  (setq bijin-tokei-last-display-time "")
  (setq bijin-tokei-timer (run-with-timer t 1 'bijin-tokei))
  (let ((selected))
    (setq selected (selected-window))
    (switch-to-buffer-other-window "*bijin-tokei*")
    (select-window selected)))

(defun bijin-tokei-stop ()
  "美人時計の停止"
  (interactive)
  (cancel-timer bijin-tokei-timer)
  (kill-buffer "*bijin-tokei*"))

(defun bijin-tokei ()
  "更新の必要のあるものだけ"
  (if (not
      (equal
       bijin-tokei-last-display-time 
       (format-time-string "%H%M" (current-time))))
     (progn
       (bijin-tokei-update)
       (setq 
        bijin-tokei-last-display-time 
        (format-time-string "%H%M" (current-time))))))

(defun bijin-tokei-update ()
  "美人時計のバッファを更新する"
  (let ((start-buffer (current-buffer)))
    (setq bijin-jpg-data
          (url-http-get
           (concat bijin-tokei-url-prefix
                   bijin-tokei-genre
                   bijin-tokei-url-mid
                   (format-time-string "%H%M" (current-time))
                   bijin-tokei-url-postfix) nil))
    (set-buffer
     (get-buffer-create "*bijin-tokei*"))
    (image-mode-as-text)
    (erase-buffer)
    (insert bijin-jpg-data)
    (image-mode)
    (set-buffer start-buffer)))

(defun url-http-get (url args)
  "Send ARGS to URL as a GET request."
  (let (
        (response-string nil)
        (url-request-method "GET")
        (url-request-data
         (mapconcat (lambda (arg)
                      (concat (url-hexify-string (car arg))
                              "="
                              (url-hexify-string (cdr arg))))
                    args
                    "&")))
    (switch-to-buffer
     (url-retrieve-synchronously
      (concat url "?" url-request-data)))
    (goto-char (point-min))
    (re-search-forward "\n\n")
    (setq response-string
          (buffer-substring-no-properties
           (point) (point-max)))
    (kill-buffer (current-buffer))
    response-string))

(provide 'bijin-tokei)

;;; pairpro.el ends here
