package com.hegx.service;

import com.hegx.base.service.BaseService;
import com.hegx.dto.OrderEntityDto;

import java.util.List;

public interface OrderService extends BaseService<OrderEntityDto> {

    /*根据id查询相应的订单*/
    public OrderEntityDto getByOrderId(Long id);

    /*查询所有审核状态的订单*/
    public List<OrderEntityDto> getAllForFlow(Short status);

    /*根据订单ID删除相应的记录*/
    public void deleteByOrderId(Long orderId);

    /*根据用户查询订单*/
    public List<OrderEntityDto> myOrder(Integer userId);
}
