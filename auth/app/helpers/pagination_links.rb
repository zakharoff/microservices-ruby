module PaginationLinks
  def pagination_links(dataset)
    return {} if dataset.pagination_record_count.zero?

    {
      first: make_link(1),
      last: make_link(dataset.page_count),
      next: dataset.next_page ? make_link(dataset.next_page) : nil,
      prev: dataset.prev_page ? make_link(dataset.prev_page) : nil
    }
  end

  private

  def make_link(page)
    query = URI.encode_www_form(request.GET.merge('page' => page))
    "#{request.url}?#{query}"
  end
end
