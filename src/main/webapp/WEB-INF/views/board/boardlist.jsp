<%--
  Created by IntelliJ IDEA.
  User: jenny
  Date: 2020-06-17
  Time: 오후 3:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html style="margin: 0 !important; padding: 0 !important;">
<head>
    <title>정보마당 | 모둠전</title>
    <link rel="stylesheet" href="/css/board/boardlist.css">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/css/sidenavbar.css">
    <link rel="stylesheet" href="/css/chat.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="/js/scrollTop.js"></script>

</head>
<body>

<div class="nav_container">
    <div class="menubar">
        <jsp:include page="../../views/navbar.jsp" />
    </div>
    <div class="sidenavbar">
        <jsp:include page="../../views/sidebar.jsp" />
    </div>
</div>

<section class="description_intro">
    <div class="YL">
        <div class="description_intro_auto">
            <nav class="side_nav" img src="/image/introImages/side_navbar.png">
                <h2 class="side_nav_img">
                    <p>고객지원</p>
                </h2>
                <ul class="nav_ul">
                    <li class="nav_li" onclick="location.href='/notice/noticeList'">
                        공지사항
                    </li>
                    <li class="nav_li" onclick="location.href='/board/boardlist'">
                        정보마당
                    </li>
                    <li class="nav_li" onclick="location.href='/mail/feedback'">
                        문의사항
                    </li>
                </ul>
            </nav>

            <div class="board-section">
                <h4 class="Dda1">정보마당</h4>
                <hr style="margin: 10px 0px 10px 0px;">
                <div class="form-group row justify-content-end">
                    <form action="search.do" method="post">
                        <div class="w100" style="padding-right:10px; float:left;">
                            <select class="form-control form-control-sm" name="searchType" id="searchType">
                                <option value="title">제목</option>
                                <option value="writer">작성자</option>
                            </select>
                        </div>
                        <input type="text" class="form-control form-control-sm" name="keyWord" id="keyWord" placeholder="키워드">
                        <button type="submit" id="search_Btn">검색</button>
                    </form>
                </div>
                <div style="text-align: left; padding-bottom: 5px;">
                    총 게시글 수 : ${pagination.listCnt }
                </div>
                <form id="Board">
                    <table class="table table-hover">
                        <tr class="mainlist">
                            <td id="boardid">번호</td>
                            <td id="title">제목</td>
                            <td id="writer">작성자</td>
                            <td id="date">날짜</td>
                            <td id="count">조회수</td>
                        </tr>

                        <c:forEach var="dto" items="${board}" varStatus="status">
                            <tr class="boardlist">
                                <td>${status.index+1+(pagination.curPage-1)*15}</td>

                                <td class="listTitle"
                                    onclick="location.href='/board/pageview?BoardId=${dto.boardId}';">${dto.b_Title}</td>

                                <td>${dto.b_Writer}</td>
                                <td>${dto.b_Date}</td>
                                <td>${dto.b_Count}</td>
                            </tr>
                        </c:forEach>
                    </table>

                    <div class="wrapper">
                        <ul class="pager">
                            <c:if test="${pagination.curPage ne 1}">
                                <li class="pager__item pager__item--prev"><a class="pager__link" href="#"
                                                                             onClick="fn_paging('${pagination.prevPage }')">
                                    <<</a></li>
                            </c:if>
                            <c:forEach var="pageNum" begin="${pagination.startPage }" end="${pagination.endPage }">
                                <c:choose>
                                    <c:when test="${pageNum eq  pagination.curPage}">
                                        <li class="pager__item active"><a class="pager__link" href="#"
                                                                          onClick="fn_paging('${pageNum }')">${pageNum }</a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="pager__item"><a class="pager__link" href="#"
                                                                   onClick="fn_paging('${pageNum }')">${pageNum }</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:if test="${pagination.curPage ne pagination.pageCnt && pagination.pageCnt > 0}">
                                <li class="pager__item pager__item--next"><a class="pager__link" href="#"
                                                                             onClick="fn_paging('${pagination.nextPage }')">
                                    >></a></li>
                            </c:if>
                        </ul>
                    </div>

                </form>
                <div class="button">
                    <button type="button" id="write_btn" onclick="location.href='/board/write'">글쓰기</button>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="button_div">
    <button type="button" id="up_button">
        <img src="/image/introImages/up-arrow.png" class="upbutton_img"/>
    </button>
</div>
<div id="chat">
    <script>
        function showchat() {
            var xPos = (document.body.offsetWidth) - 655;
            var yPos = (window.screen.height / 2) - 400;
            window.open("/chat", "실시간채팅창", "width=555, height=660, left=" + xPos + ", top=" + yPos);
        }
    </script>
    <button type="button" class="chat_fixed" onclick="showchat()">
        <img src="/image/homeImages/chat.png" class="chatbutton_img"/>
    </button>
</div>

<footer>
    <jsp:include page="../footer.jsp"/>
</footer>

</body>
<script>
    function fn_paging(curPage) {
        location.href = "/board/boardlist?curPage=" + curPage;
    }

    $(document).on('click', '#btnSearch', function (e) {
        e.preventDefault();
        var url = "${pageContext.request.contextPath}/board/boardlist";
        url = url + "?searchType=" + $('#searchType').val();
        url = url + "&keyword=" + $('#keyword').val();
        location.href = url;
        console.log(url);
    });
</script>
</html>