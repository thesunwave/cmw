module ApplicationHelper
  def quote_text(quote)
    if current_user.present?
      if current_user.lang == 'ru'
        quote.text_rus
      else
        quote.text_eng
      end
    else
      quote.text_rus
    end
  end

  def quote_author(quote)
    if current_user.present?
      if current_user.lang == 'ru'
        quote.author_rus
      else
        quote.author_eng
      end
    else
      quote.author_rus
    end
  end
end
