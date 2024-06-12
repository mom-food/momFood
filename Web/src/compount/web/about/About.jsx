import React from "react";
import "./about.css";
import { Link } from "react-router-dom";
import { Navigation, Pagination, Autoplay } from "swiper/modules";
import { Swiper, SwiperSlide } from "swiper/react";
import "swiper/css";
import "swiper/css/navigation";
import "swiper/css/pagination";
import "swiper/css/scrollbar";
export default function About() {
  return (
    <div className="">
      <section className="about-style about-us container">
        <div className="row ">
          <h1 className="text-center text-danger">About us</h1>
          <h2>Source</h2>
          <div className="col-md-8 about-info">
            <p>
              From the mountains together: In 1998, the Dr. Cécil Foundation was
              started Developing cosmetics and hair care products After several
              years, the first commercial brand and the first product produced
              by it were born Dr. Cecil.lab
            </p>
            <h2>The Date</h2>
            <p>
              Since then, Dr. Cecil's products have specialized, developed, and
              obtained patents in this wonderful field, and the right beginning
              was by using organic materials selected from the finest types of
              carefully selected herbs from all the countries in the world that
              are famous for them. The goal was to obtain the most luxurious
              types of cosmetics, which are classified as international
            </p>
          </div>

          <div className="col-md-4 image-about">
            <img
              src="/img/header/pexels-daniele-la-rosa-messina.jpg"
              className="images-about"
            />
          </div>
        </div>
      </section>
      <section className="about-style about-us container">
        <div className="row">
          <h1 className="text-center text-danger">The Philosophy</h1>
          <div className="col-md-8 about-info">
            <p className="mt-5">
              Our mission is to have a strong presence in the global market
              through high-quality products using the latest advanced production
              technologies while respecting nature and the environment{" "}
            </p>
          </div>

          <div className="col-md-4 image-about">
            <img src="/img/header/Screenshot-1.png" className="images-about " />
          </div>
        </div>
      </section>
      <section className="about-style about-us container">
        <div className="row">
          <h1 className="text-center text-danger">The Mission</h1>
          <div className="col-md-8 about-info">
            <p className="mt-5 ">
              Our philosophy is simply to provide safe, innovative, effective
              cosmetics that are free of parabens or heavy metals, and tested to
              suit the most sensitive people.
            </p>
          </div>

          <div className="col-md-4 image-about">
            <img
              src="/img/header/pexels-monica-turlui.jpg"
              className="images-about"
            />
          </div>
        </div>
      </section>
      <section className="about-style about-us container">
        <div className="row">
          <h1 className="text-center text-danger">The Vision</h1>
          <div className="col-md-8 about-info ">
            <p className="mt-5">
              Now that Dubai Tejar Group has acquired ownership of the brand
              (Dr.Cecil), plans have become to be the leading products in the
              skin care and follow-up market with the same high quality, with a
              focus on supporting our agents in all countries.
            </p>
          </div>

          <div className="col-md-4 image-about">
            <img src="/img/header/the vision.jpg" className="images-about " />
          </div>
        </div>
      </section>
      <section className="about-style about-us container">
        <div className="row">
          <h1 className="text-center text-danger">Globally</h1>
          <div className="col-md-8 about-info ">
            <p className="mt-5">
              Dr. Cecil's products are available in international markets with
              names and specifications that suit those countries and regions.
              Now, Dr. Cecil's products will be strongly present in the Arabian
              Gulf, North Africa, and Middle East markets through a network of
              agents specialized in Arab women's needs for high-quality
              cosmetics products.
            </p>
          </div>
          <div className="col-md-4 image-about">
            <img
              src="/img/header/GJ8m39MX0AAESdE.jpg"
              className="images-about "
            />
          </div>
        </div>
      </section>
      <section className="about-style about-us container">
        <div className="row">
          <h1 className="text-center text-danger">The Support</h1>
          <div className="col-md-8 about-info ">
            <p className="mt-5">
              Dr. Cecil products provide all support to our agents in the Arab
              countries through all means of social media and a strong presence
              in festivals, exhibitions and events specialized in the field of
              skin care and beauty.
            </p>
          </div>
          <div className="col-md-4 image-about">
            <img src="/img/header/support.webp" className="images-about " />
          </div>
        </div>
      </section>
      <section className="about-style about-us container">
        <div className="row">
          <h1 className="text-center text-danger">The Guarantees</h1>
          <div className="col-md-8 about-info ">
            <p className="mt-5">
              ICEA Membership COSMOS Membership Certificates of tests against
              heavy metals, microbiological tests, products free of genetic
              modification, non-use of artificial colorings, non-use of ethyl
              alcohol, respect for the environment through the production
              process.{" "}
            </p>
          </div>
          <div className="col-md-4 image-about">
            <img src="/img/header/Guarantees.jpg" className="images-about " />
          </div>
        </div>
      </section>
      <section className="about-style about-us container">
        <div className="row">
          <h1 className="text-center text-danger">Dr.Cecil products</h1>
          <div className="col-md-8 about-info ">
            <p className="mt-5">
              Dr. Cecil's products meet the needs of both women and men. Dr.
              Cecil's products include skin care, body care, and many other
              products, all of which are certified organic with a high
              percentage of natural ingredients and using the most effective
              extraction techniques in order to preserve the effective
              properties that are benefited from Before the consumer
            </p>
          </div>
          <div className="col-md-4 image-about">
            <img
              src="/img/header/Dr.Cecil-products.avif"
              className="images-about "
            />
          </div>
        </div>
      </section>
      {/* <div className="Swiper my-5">
        <h1 className="text-center">Some Products</h1>
        <div>
          <Swiper
            modules={[Navigation, Pagination, Autoplay]}
            loop={true}
            autoplay={{
              delay: 1000,
            }}
            pagination={{
              clickable: true,
            }}
            breakpoints={{
              600: {
                slidesPerView: 1.5,
              },
              900: {
                slidesPerView: 4.5,
              },
              1024: {
                slidesPerView: 4.5,
              },
            }}
          >
            <SwiperSlide>
              <div className="Activity-image w-100">
                <img
                  src="/img/about/تفتيح المناطق الحساسة.png"
                  className="img-fluid"
                />
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className="Activity-image w-100">
                <img
                  src="/img/about/تفتيح المناطق السوداء.png"
                  className="img-fluid"
                />
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className="Activity-image w-100">
                <img
                  src="/img/about/تفتيح تحت العين.png"
                  className="img-fluid"
                />
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className="Activity-image w-100">
                <img src="/img/about/Untitled-1-01.png" className="img-fluid" />
              </div>
            </SwiperSlide>

            <SwiperSlide>
              <div className="Activity-image w-100">
                <img
                  src="/img/about/منتج نفخ الارداف.png"
                  className="img-fluid"
                />
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className="Activity-image w-100">
                <img
                  src="/img/about/منتجات تخسيس المعدة.png"
                  className="img-fluid"
                />
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className="Activity-image w-100">
                <img src="/img/about/نفخ الشفايف.png" className="img-fluid" />
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className="Activity-image w-100">
                <img src="/img/about/نفخ الشفتين.png" className="img-fluid" />
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className="Activity-image w-100">
                <img src="/img/about/نفخ الصدر.png" className="img-fluid" />
              </div>
            </SwiperSlide>
          </Swiper>
        </div>
      </div> */}
    </div>
  );
}
