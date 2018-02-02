package com.hegx.controller;

import com.hegx.controller.util.Permission;
import com.hegx.controller.util.Status;
import com.hegx.dto.OrderEntityDto;
import com.hegx.dto.UserEntityDto;
import com.hegx.po.Belong;
import com.hegx.po.Code;
import com.hegx.po.Delivery;
import com.hegx.po.Fashion;
import com.hegx.service.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private FashionService fashionService;
    @Autowired
    private CodeService codeService;
    @Autowired
    private DeliveryService deliveryService;
    @Autowired
    private BelongService belongService;

    /**查询所有流程订单**/
    @RequestMapping(value = "myOrder/{userId}")
    private ModelAndView myOrder(@PathVariable Integer userId) {
        List<OrderEntityDto> orderList = orderService.myOrder(userId);
        packager(orderList);
        return new ModelAndView("list-myOrder").addObject("orderList",orderList);
    }

    /**查询所有流程订单**/
    @RequestMapping(value = "getFlowOrder/{status}")
    private ModelAndView getFlowOrder(@PathVariable Short status) {
        OrderEntityDto orgOrderEntityDto = null;
        List<OrderEntityDto> orderList = orderService.getAllForFlow(status);
        orderList = packager(orderList);
        if (status==Status.end)
        {
            orgOrderEntityDto = orderList.get(0);
            return new ModelAndView("order-list-flow").addObject("orderList",orderList).addObject("orgOrderEntityDto",orgOrderEntityDto);
        }
        return new ModelAndView("order-list-flow").addObject("orderList",orderList);
    }


    /**新增订单**/
    @RequestMapping(value = "doAddOrder",method = {RequestMethod.POST})
    private ModelAndView doAddOrder(OrderEntityDto orderEntityDto,
                                    Code code,
                                    Delivery delivery,
                                    Belong belong,
                                    HttpServletRequest request) {
        orderEntityDto.setCreateDate(new Date());//创建时间
        orderEntityDto.setStatus(Status.add);//订单状态
        orderEntityDto.setGetOrderDate(new Date());//设置接单日期

        StringBuffer orderNumber = new StringBuffer();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMddhhmmss");
        String newDate =format.format(new Date());
        orderNumber.append(newDate);
        orderEntityDto.setOrderNumber(orderNumber.toString());//设置订单编号

        code.setTotalCount(codeService.doTotalcount(code));//设置尺码总数

        deliveryService.insert(delivery);
        belongService.insert(belong);
        codeService.insert(code);

        orderEntityDto.setBelongId(belong.getId());
        orderEntityDto.setDeliveryId(delivery.getId());
        orderEntityDto.setCodeId(code.getId());

        orderService.insert(orderEntityDto);

        List<OrderEntityDto> orderList = orderService.getAll();
        orderList = packager(orderList);

        HttpSession session = request.getSession();
        UserEntityDto orgUserEntityDto = (UserEntityDto)session.getAttribute("orgUserEntityDto");

        if (orgUserEntityDto.getPermission()== Permission.market)
        {
            return new ModelAndView("list-myOrder").addObject("orderList",orderList);
        }
        return new ModelAndView("order-list-flow").addObject("orderList",orderList);
    }

    /**填写订单**/
    @RequestMapping(value = "writeOrder")
    private ModelAndView writeOrder() {
        List<Fashion> list = fashionService.getAll();
        return new ModelAndView("order-write").addObject("list",list);
    }


    /**拿到数据转发到编辑订单页面**/
    @RequestMapping(value = "toEditOrder/{orderId}")
    private ModelAndView toEditOrder(@PathVariable long orderId) {
        OrderEntityDto orderEntityDto = orderService.getByOrderId(orderId);
        Code code = codeService.getById(orderEntityDto.getCodeId());
        Delivery delivery = deliveryService.getById(orderEntityDto.getDeliveryId());
        Belong belong = belongService.getById(orderEntityDto.getBelongId());
        List<Fashion> fashionList = fashionService.getAll();

        return new ModelAndView("order-edit").addObject("orderEntityDto",orderEntityDto)
                .addObject("code",code)
                .addObject("delivery",delivery)
                .addObject("belong",belong)
                .addObject("fashionList",fashionList);
    }


    /**拿到数据转发到流程订单页面**/
    @RequestMapping(value = "editOrder/{orderId}")
    private ModelAndView editOrder(@PathVariable long orderId) {
        OrderEntityDto orderEntityDto = orderService.getByOrderId(orderId);
        Code code = codeService.getById(orderEntityDto.getCodeId());
        Delivery delivery = deliveryService.getById(orderEntityDto.getDeliveryId());
        Belong belong = belongService.getById(orderEntityDto.getBelongId());
        List<Fashion> fashionList = fashionService.getAll();
        orderEntityDto.setShowStatus(Status.status[orderEntityDto.getStatus()]);
        return new ModelAndView("order-edit-flow").addObject("orderEntityDto",orderEntityDto)
                .addObject("code",code)
                .addObject("delivery",delivery)
                .addObject("belong",belong)
                .addObject("fashionList",fashionList);
    }

    /**新增订单**/
    @RequestMapping(value = "doEditOrder",method = {RequestMethod.POST})
    private ModelAndView doEditOrder(OrderEntityDto orderEntityDto,
                                     Code code,
                                     Delivery delivery,
                                     Belong belong,
                                     HttpServletRequest request) {

        HttpSession session = request.getSession();
        UserEntityDto orgUserEntityDto = (UserEntityDto)session.getAttribute("orgUserEntityDto");

        if (orgUserEntityDto.getPermission()== Permission.market)
        {
            orderEntityDto =  orderService.getByOrderId(orderEntityDto.getOrderId());
            if (orderEntityDto.getStatus()!=Status.add)
            {
                return new ModelAndView("error");
            }
            update(orderEntityDto,code,delivery,belong);
            List<OrderEntityDto> orderList = orderService.getAll();
            orderList = packager(orderList);
            return new ModelAndView("list-myOrder").addObject("orderList",orderList);
        }


        update(orderEntityDto,code,delivery,belong);
        List<OrderEntityDto> orderList = orderService.getAll();
        orderList = packager(orderList);
        return new ModelAndView("order-list-all").addObject("orderList",orderList);
    }

    /**处理跟新流程订单**/
    @RequestMapping(value = "doFlowOrder",method = {RequestMethod.POST})
    private ModelAndView doFlowOrder(OrderEntityDto orderEntityDto,
                                     Code code,
                                     Delivery delivery,
                                     Belong belong) {
        if (orderEntityDto.getEndReason().trim().equals(""))
        {
            orderEntityDto.setEndReason(null);
        }
        if (!StringUtils.isEmpty(orderEntityDto.getEndReason()))
        {
            orderEntityDto.setEndDate(new Date());
            orderEntityDto.setStatus(Status.end);
        }
        if(!StringUtils.isEmpty(orderEntityDto.getMessage())){
            Short status =  orderEntityDto.getStatus();
            if(status<=5)
            {
                Integer flag = status-1;
                setStatus(orderEntityDto,flag);
            }
        }else {
            Short status =  orderEntityDto.getStatus();
            if(status<=5)
            {
                Integer flag = status+1;
                setStatus(orderEntityDto,flag);
            }
        }

        update(orderEntityDto,code,delivery,belong);
        List<OrderEntityDto> orderList = orderService.getAll();
        orderList = packager(orderList);
        return new ModelAndView("order-list-flow").addObject("orderList",orderList);
    }

    /**删除**/
    @RequestMapping(value = "deleteOrder/{orderId}")
    @ResponseBody
    private OrderEntityDto deleteOrder(@PathVariable long orderId) {
        OrderEntityDto orderEntityDto =  orderService.getByOrderId(orderId);
        orderService.deleteByOrderId(orderId);
        codeService.deleteById(orderEntityDto.getCodeId());
        belongService.deleteById(orderEntityDto.getBelongId());
        deliveryService.deleteById(orderEntityDto.getDeliveryId());
        return  new OrderEntityDto("deleted");
    }

    /**所有订单**/
    @RequestMapping(value = "listOrder")
    private ModelAndView listOrder() {
        List<OrderEntityDto> orderList = orderService.getAll();
        orderList = packager(orderList);
        return new ModelAndView("order-list-all").addObject("orderList",orderList);
    }

    /**封装展示全部订单状态**/
    private List<OrderEntityDto> packager(List<OrderEntityDto> orderList) {
        if (!CollectionUtils.isEmpty(orderList))
        {
            for (OrderEntityDto orderEntityDto:orderList)
            {
                orderEntityDto.setShowStatus(Status.status[orderEntityDto.getStatus()]);
            }

        }
        return  orderList;
    }

    /**封装更新代码**/
    private void update(OrderEntityDto orderEntityDto, Code code, Delivery delivery, Belong belong) {
        orderService.update(orderEntityDto);
        codeService.update(code);
        deliveryService.update(delivery);
        belongService.update(belong);
    }

    /**设置状态**/
    private void setStatus(OrderEntityDto orderEntityDto,Integer flag) {
        if (flag==Status.add)
            orderEntityDto.setStatus(Status.add);
        if (flag==Status.check)
            orderEntityDto.setStatus(Status.check);
        if (flag==Status.design)
            orderEntityDto.setStatus(Status.design);
        if (flag==Status.examine)
            orderEntityDto.setStatus(Status.examine);
        if (flag==Status.account)
            orderEntityDto.setStatus(Status.account);
        if (flag==Status.product)
            orderEntityDto.setStatus(Status.product);
        if (flag==Status.finish)
            orderEntityDto.setStatus(Status.finish);
    }
}
