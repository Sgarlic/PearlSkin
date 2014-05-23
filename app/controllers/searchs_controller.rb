require 'will_paginate/array'
class SearchsController < ApplicationController
  def search
  	@query_content = params[:query_content]
  	failed_hint = "矮油~换个关键字搜索呗~！"
  	if @query_content.nil? || @query_content == ""
  	  flash[:failed] = "不输入关键字是要作甚~！"
  	else
  	  terms = @query_content.split(' ')
  	  item_terms = Array.new
  	  brand_search_result = nil
  	  # Find brands.
  	  terms.each do |term|
  	 	brand_result = Brand.where("lower(brand_chinese) = '#{term.downcase}' OR lower(brand_english) = '#{term.downcase}'")
  		if brand_result.size == 0
  		  item_terms << term
  		else	
  		  if brand_search_result.nil?
	  	    brand_search_result = brand_result
  		  else
  		    flash[:failed] = failed_hint
  		    return
  		  end
  		end
  	  end

  	  query=""

  	  if !brand_search_result.nil?
  	  	query = "(brand_id = #{brand_search_result[0].id}) AND "
  	  end

  	  item_search_result = Array.new
  	  content_search_result = Array.new

  	  if item_terms.size>0
	  	item_queries = Array.new
	  	content_queries = Array.new
	  	# Find items
	  	item_terms.each do |item_term|
	  	  item_queries << "((lower(item_chinese) LIKE '%#{item_term.downcase}%') OR (lower(item_english) LIKE '%#{item_term.downcase}%') OR (lower(character) LIKE '%#{item_term.downcase}%'))" 
	  	  content_queries << "(lower(content) LIKE '%#{item_term.downcase}%')"
	  	end
	  	query += item_queries.join(" AND ")

	  	item_search_result = Item.where(query)

	  	content_search_result = Comment.where(content_queries.join(" AND "))
  	  end

  	  if brand_search_result.nil? && item_search_result.size ==0 && content_search_result.size ==0
  	  	flash[:failed] = failed_hint
  		return
  	  end

  	  @final_result = Array.new

  	  if !brand_search_result.nil?
  	  	@final_result << {
  	  		:tag => 0,
  	  		:result => brand_search_result[0]
  	  	}
  	  end

  	  item_search_result.each do |item_result|
  	  	@final_result << {
  	  		:tag => 1,
  	  		:result => item_result
  	  	}
  	  end
  	 
  	  content_search_result.each do |content_result|
  	  	@final_result << {
  	  		:tag => 2,
  	  		:result => content_result
  	  	}
  	  end
  	  @final_result = @final_result.paginate(page: params[:page], :per_page => 10)
    end
  end
end
